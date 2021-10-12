//
//  ChemicalsListViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 11.10.2021.
//

import Foundation

protocol RecipeMaterialsListViewViewModelType: AnyObject {
    func numberOfRowsInSection() -> Int
    func selectRow(atIndexPath indexPath: IndexPath)
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ChemicalsListCellViewModelType?
    func itemToPass() -> String
}

class RecipeMaterialsListViewViewModel: RecipeMaterialsListViewViewModelType {
    
    var chemicalsList: [String] = ["Chem 1", "Chem 2", "Chem 3"]
    private var selectedIndexPath: IndexPath?

    func numberOfRowsInSection() -> Int {
        return chemicalsList.count
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> ChemicalsListCellViewModelType? {

        let item = chemicalsList[indexPath.row]

        return ChemicalsListCellViewModel(item: item)
    }

    func itemToPass() -> String {
        guard let selectedIndexPath = selectedIndexPath else {
            return ""
        }
        return chemicalsList[selectedIndexPath.row]
    }

}

