//
//  LocalStorageService.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import Foundation
import UIKit

class LocalStorageService {

    static let key = "Materials"

    // Save new Material object
    class func save(object: Material) {
        DispatchQueue.global(qos: .default).async {
            checkIfArrayExists(key: key)

            do {
                let currentArray = try UserDefaults.standard.getObject(forKey: key, castTo: [Material].self)
                var newArray = currentArray
                newArray.append(object)
                try UserDefaults.standard.setObject(newArray, forKey: key)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    class func genericSave<T: Codable>(object: T, key: String) {
        do {
            try UserDefaults.standard.setObject(object, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    class func genericStorageUpdate<T: Codable>(object: T, key: String) {
        print(type(of: T.self))

            do {
                let currentArray = try UserDefaults.standard.getObject(forKey: key, castTo: T.self)
                var newArray = currentArray
                //newArray.append(object)
                try UserDefaults.standard.setObject(newArray, forKey: key)
            } catch {
                print(error.localizedDescription)
            }
        
    }

    // Retrieve array of Material
    class func retrieve(completion: @escaping ([Material]?, [String : Bool]) -> Void) {
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
            if let idx = materialsToEdit.firstIndex(where: { $0.name == itemToRemove.name && $0.quantity == itemToRemove.quantity && $0.info == itemToRemove.info && $0.type == itemToRemove.type}) {

                materialsToEdit.remove(at: idx)
            }
            try UserDefaults.standard.setObject(materialsToEdit, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    // Check if array in UserDefaults
    static func checkIfArrayExists(key: String) {
        do {
            let initialArray: [Material] = []
            let array = try? UserDefaults.standard.getObject(forKey: key, castTo: [Material].self)
            if (array == nil) {
                do {
                    try UserDefaults.standard.setObject(initialArray, forKey: key)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

}
