//
//  AddMaterialViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

class AddMaterialViewControllerViewModel: AddMaterialViewControllerViewModelType {

    func addNewMaterial(type: String, quantity: String, name: String, info: String) {

        // Create material from item parameters
        let material = Material(type: type, name: name, quantity: quantity, info: info, marked: false)

        // Save material to UserDefaults
        LocalStorageService.save(object: material)
    }

}
