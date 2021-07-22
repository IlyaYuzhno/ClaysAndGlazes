//
//  LocalStorageService.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import Foundation

class LocalStorageService {

    static let key = "Materials"

    // Save new Material object
    class func save(object: Material) {
        DispatchQueue.global(qos: .default).async {
            checkIfArrayExists()

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

    // Retrieve array of Material
    class func retrieve(completion: @escaping ([Material]?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            do {
            let materials = try UserDefaults.standard.getObject(forKey: key, castTo: [Material].self)
            completion(materials)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // Save array of Material after editing
    class func saveEditedList(itemToRemove: String) {
        DispatchQueue.global(qos: .default).async {

            LocalStorageService.retrieve() { materials in
                var materialsToEdit = materials
                if let idx = materialsToEdit?.firstIndex(where: { $0.name == itemToRemove }) {
                    materialsToEdit?.remove(at: idx)
                    do {
                        try UserDefaults.standard.setObject(materialsToEdit, forKey: key)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    // Check if array in UserDefaults
    static func checkIfArrayExists() {
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
