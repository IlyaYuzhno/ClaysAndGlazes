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
    func addEmptyItemRow()
    func deleteItem(forIndexPath indexPath: IndexPath)
    var delegate: AddRecipeViewControllerViewModelDelegate? { get set }
    func addNewItem(item: String)
}

protocol AddRecipeViewControllerViewModelDelegate: AnyObject {
    func reloadTableView()
}

class AddRecipeViewControllerViewModel: AddRecipeViewControllerViewModelType {

    var items = [""]
    weak var delegate: AddRecipeViewControllerViewModelDelegate?

    func numberOfRowsInSection() -> Int {
        return items.count
    }

    func addEmptyItemRow() {
        items.append("")
    }

    func addNewItem(item: String) {
        let index = items.count - 1
        items[index] = item
        delegate?.reloadTableView()
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> AddMaterialToRecipeCellViewModelType? {

        let item = items[indexPath.row]

        return AddMaterialToRecipeCellViewModel(item: item)
    }

    func deleteItem(forIndexPath indexPath: IndexPath) {
        items.remove(at: indexPath.row)
    }

}
