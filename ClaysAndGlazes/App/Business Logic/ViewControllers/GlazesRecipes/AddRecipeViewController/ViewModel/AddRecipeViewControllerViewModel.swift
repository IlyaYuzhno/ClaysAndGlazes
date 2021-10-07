//
//  AddRecipeViewControllerViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 07.10.2021.
//

import Foundation

protocol AddRecipeViewControllerViewModelType: AnyObject {
    func numberOfRowsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> AddMaterialToRecipeCellViewModelType?
    func addData(_ data: String)
}


class AddRecipeViewControllerViewModel: AddRecipeViewControllerViewModelType {

    var dataArray = ["test 1"]

    func numberOfRowsInSection() -> Int {
        return dataArray.count
    }

    func addData(_ data: String) {
        dataArray.append(data)
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> AddMaterialToRecipeCellViewModelType? {

        let item = dataArray[indexPath.row]

        return AddMaterialToRecipeCellViewModel(item: item)
    }

}
