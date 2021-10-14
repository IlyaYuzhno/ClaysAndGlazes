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
    func addNewItem(item: Chemical)
    func clearItemsList()
}

protocol AddRecipeViewControllerViewModelDelegate: AnyObject {
    func reloadTableView()
}

class AddRecipeViewControllerViewModel: AddRecipeViewControllerViewModelType {

    var items: [Chemical] = [Chemical(name: "", content: ["":0.0], formula: ["":0.0])]
    weak var delegate: AddRecipeViewControllerViewModelDelegate?
    private var segerFormulaCalculator: SegerFormulaCalculatorType?

    init(segerFormulaCalculator: SegerFormulaCalculatorType) {
        self.segerFormulaCalculator = segerFormulaCalculator
    }

    func numberOfRowsInSection() -> Int {
        return items.count
    }

    func addEmptyItemRow() {
        items.append(Chemical(name: "", content: ["":0.0], formula: ["":0.0]))
    }

    func addNewItem(item: Chemical) {
        let index = items.count - 1
        items[index] = item
        delegate?.reloadTableView()

        calculateFormula(formula: item.formula)

    }

    private func calculateFormula(formula: [String:Float]) {
        segerFormulaCalculator?.calculate(formula: formula)
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> AddMaterialToRecipeCellViewModelType? {

        let item = items[indexPath.row].name

        return AddMaterialToRecipeCellViewModel(item: item)
    }

    func deleteItem(forIndexPath indexPath: IndexPath) {
        items.remove(at: indexPath.row)
    }

    func clearItemsList() {
        items = [Chemical(name: "", content: ["":0.0], formula: ["":0.0])]
        delegate?.reloadTableView()
    }

}
