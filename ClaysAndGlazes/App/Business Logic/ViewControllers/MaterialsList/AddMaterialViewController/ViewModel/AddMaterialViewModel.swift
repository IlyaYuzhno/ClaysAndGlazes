//
//  AddMaterialViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

class AddMaterialViewControllerViewModel: AddMaterialViewControllerViewModelType {

    var presenter: ClaysTableViewPresenterType?
    var claysList: [String] = []
    var glazesList: [String] = []


    func loadClaysList(completion: @escaping (() -> ()?)) {
        guard let presenter = presenter else { return }

        presenter.present() { [weak self] (_, claysList, _, _, _) in
            self?.claysList = claysList
        }
        completion()
    }

    func addNewMaterial(type: String, quantity: String, name: String, info: String) {

        // Create material from item parameters
        let material = Material(type: type, name: name, quantity: quantity, info: info, marked: false)

        // Save material to UserDefaults
        LocalStorageService.save(object: material)
    }

}
