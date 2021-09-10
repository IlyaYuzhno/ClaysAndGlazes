//
//  LocalStorageService.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import Foundation
import UIKit

class LocalStorageService {

    private static let key = "Materials"
    private static let purchaseListKey = "purchaseList"

    // MARK: - Purchase List methods
    class func saveToPurchaseList(object: String) {
        do {
            let currentArray = try? UserDefaults.standard.getObject(forKey: purchaseListKey, castTo: [String].self)

            if currentArray == nil {
                let initialArray: [String] = []
                do {
                    try UserDefaults.standard.setObject(initialArray, forKey: purchaseListKey)
                } catch {
                    print(error.localizedDescription)
                }
            }
            var newArray = currentArray ?? []
            newArray.append(object)
            try UserDefaults.standard.setObject(newArray, forKey: purchaseListKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    // Retrieve purchase list
    class func retrievePurchaseList(completion: @escaping ([String]?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            do {
                let purchaseList = try UserDefaults.standard.getObject(forKey: purchaseListKey, castTo: [String].self)
                completion(purchaseList)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // Remove item from purchase list
    class func removeItemFromPurchaseList(itemToRemove: String) {
        do {
            var purchaseList = try? UserDefaults.standard.getObject(forKey: purchaseListKey, castTo: [String].self)
            if let idx = purchaseList?.firstIndex(where: { $0 == itemToRemove }) {
                purchaseList?.remove(at: idx)
            }
            try UserDefaults.standard.setObject(purchaseList, forKey: purchaseListKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Materials List methods
    // Save new Material object
    class func save(object: Material) {
        do {
            let currentArray = try UserDefaults.standard.getObject(forKey: key, castTo: [Material].self)
            var newArray = currentArray
            newArray.append(object)
            try UserDefaults.standard.setObject(newArray, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    // Retrieve array of Material
    class func retrieve(completion: @escaping ([Material]?, [String : Bool]) -> Void) {

        checkIfDataExists()

        DispatchQueue.global(qos: .default).async {
            do {
                let materials = try UserDefaults.standard.getObject(forKey: key, castTo: [Material].self)
                let isCollapsed = try UserDefaults.standard.getObject(forKey: "isCollapsed", castTo: [String : Bool].self)
                completion(materials, isCollapsed)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // Save array of Material after editing
    class func removeItemFromDataSource(itemToRemove: Material) {
        do {
            let materials = try UserDefaults.standard.getObject(forKey: key, castTo: [Material].self)
            var materialsToEdit = materials
            if let idx = materialsToEdit.firstIndex(where: { $0.name == itemToRemove.name && $0.quantity == itemToRemove.quantity && $0.info == itemToRemove.info && $0.type == itemToRemove.type && $0.unit == itemToRemove.unit && $0.marked == itemToRemove.marked}) {

                materialsToEdit.remove(at: idx)
            }
            try UserDefaults.standard.setObject(materialsToEdit, forKey: key)
        } catch {
            print(error.localizedDescription)
        }

    }

    // Check if any data exists in UserDefaults
    static func checkIfDataExists() {
        do {
            let initialArray: [Material] = []
            let initialIsCollapsed = ["" : true]

            let array = try? UserDefaults.standard.getObject(forKey: "Materials", castTo: [Material].self)
            let isCollapsed = try? UserDefaults.standard.getObject(forKey: "isCollapsed", castTo: [String : Bool].self)

            if (array == nil || isCollapsed == nil) {
                do {
                    try UserDefaults.standard.setObject(initialArray, forKey: "Materials")
                    try UserDefaults.standard.setObject(initialIsCollapsed, forKey: "isCollapsed")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - For future use
    class func genericSave<T: Codable>(object: T, key: String) {
        do {
            try UserDefaults.standard.setObject(object, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    class func genericStorageUpdate<T: Codable>(object: T, key: String) {
        do {
            let currentArray = try UserDefaults.standard.getObject(forKey: key, castTo: T.self)
            let newArray = currentArray
            //newArray.append(object)
            try UserDefaults.standard.setObject(newArray, forKey: key)
        } catch {
            print(error.localizedDescription)
        }

    }


}
