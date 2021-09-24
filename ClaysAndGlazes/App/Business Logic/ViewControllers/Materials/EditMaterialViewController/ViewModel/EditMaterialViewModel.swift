//
//  EditMaterialViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 28.07.2021.
//

import Foundation

class EditMaterialViewModel: EditMaterialViewModelType {

    var material: Material
    let storageKey = MaterialsLocalStorageKeys.materialsKey

    init(material: Material) {
        self.material = material
    }

    var name: String {
        return material.name
    }

    var quantity: Float {
        return material.quantity
    }

    var info: String {
        return material.info
    }

    var type: String {
        return material.type
    }

    var unit: String {
        return material.unit
    }

    var marked: Bool {
        return material.marked
    }

    func getMaterial() -> Material {
        return material
    }

    func editMaterial(itemName: String, itemQuantity: Float, itemInfo: String) {
        let itemToRemove = material
        MaterialsLocalStorageService.removeItemInStorage(itemToRemove: itemToRemove, key: storageKey)

        // Create new material from item parameters
        let material = Material(type: type, name: itemName, quantity: itemQuantity, unit: unit, info: itemInfo, marked: marked )

        // Save new material to UserDefaults
        MaterialsLocalStorageService.saveDataToStorage(object: material, key: storageKey)
    }

}
