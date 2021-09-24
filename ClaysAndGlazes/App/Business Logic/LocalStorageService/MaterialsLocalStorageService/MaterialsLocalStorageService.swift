//
//  MaterialsLocalStorageService.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import Foundation
import UIKit

class MaterialsLocalStorageService {

    private static let materialsKey = MaterialsLocalStorageKeys.materialsKey
    private static let purchaseListKey = MaterialsLocalStorageKeys.purchaseListKey
    private static let materialsStatisticListKey = MaterialsLocalStorageKeys.materialsStatisticListKey
    private static let isCollapsedKey = MaterialsLocalStorageKeys.isCollapsedKey

    // MARK: - Generic methods
    class func saveDataToStorage<T: Codable>(object: T, key: String) {

        if T.self == Material.self {
            checkIfMaterialsListDataExists()
        }

        do {
            let currentData = try? UserDefaults.standard.getObject(forKey: key, castTo: [T].self)

            if currentData == nil {
                let initialData: [T] = []
                do {
                    try UserDefaults.standard.saveObject(initialData, forKey: key)
                } catch {
                    print(error.localizedDescription)
                }
            }

            var newData = currentData ?? []
            newData.append(object)
            try UserDefaults.standard.saveObject(newData, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    class func retrieveDataFromStorage<T: Codable>(key: String, type: T.Type, completion: @escaping ([T]?) -> Void) {

        if T.self == Material.self {
            checkIfMaterialsListDataExists()
        }
        
        DispatchQueue.global(qos: .default).async {
            do {
                let data = try? UserDefaults.standard.getObject(forKey: key, castTo: [T].self)

                if data == nil {
                    let initialData: [T] = []
                    do {
                        try UserDefaults.standard.saveObject(initialData, forKey: key)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                completion(data)
            }
        }
    }

    class func removeItemInStorage<T: Codable & Equatable>(itemToRemove: T, key: String) {
        do {
            var data = try? UserDefaults.standard.getObject(forKey: key, castTo: [T].self)
            if let index = data?.firstIndex(where: { $0 == itemToRemove }) {
                data?.remove(at: index)
            }
            try UserDefaults.standard.saveObject(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Materials List methods

    // Retrieve array of Material, non-genericable
    class func retrieveMaterialsData(completion: @escaping ([Material]?, [String : Bool]) -> Void) {

        checkIfMaterialsListDataExists()

        do {
            let materials = try UserDefaults.standard.getObject(forKey: materialsKey, castTo: [Material].self)
            let isCollapsed = try UserDefaults.standard.getObject(forKey: isCollapsedKey, castTo: [String : Bool].self)
            completion(materials, isCollapsed)
        } catch {
            print(error.localizedDescription)
        }
    }

    // Check if Materials List data exists in UserDefaults
    static func checkIfMaterialsListDataExists() {
        do {
            let initialData: [Material] = []
            let initialIsCollapsedData = ["" : true]

            let data = try? UserDefaults.standard.getObject(forKey: materialsKey, castTo: [Material].self)
            let isCollapsedData = try? UserDefaults.standard.getObject(forKey: isCollapsedKey, castTo: [String : Bool].self)

            if (data == nil || isCollapsedData == nil) {
                do {
                    try UserDefaults.standard.saveObject(initialData, forKey: materialsKey)
                    try UserDefaults.standard.saveObject(initialIsCollapsedData, forKey: isCollapsedKey)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Materials Statistic methods
    class func retrieveStatisticItem(item: MaterialStatisticItem) -> MaterialStatisticItem {
        var itemToReturn = MaterialStatisticItem(name: "", quantity: 0, unit: "")

        guard let itemsList = try? UserDefaults.standard.getObject(forKey: materialsStatisticListKey, castTo: [MaterialStatisticItem].self) else { return itemToReturn }

        if let index = itemsList.firstIndex(where: { $0.name == item.name }) {
            itemToReturn = itemsList[index]
        }
        return itemToReturn
    }

    // MARK: - Materials List Section isCollapsed state save
    class func isSectionCollapsedStateSave<T: Codable>(object: T, key: String) {
        do {
            try UserDefaults.standard.saveObject(object, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
}
