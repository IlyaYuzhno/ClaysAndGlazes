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
    func loadData(completion: @escaping (() -> ()?))
    func itemToPass() -> Chemical
}

class RecipeMaterialsListViewViewModel: RecipeMaterialsListViewViewModelType {

    var chemicalsList: [Chemical] = []
    private var selectedIndexPath: IndexPath?
    private var storageService: JSONDataGetable?
    private let chemicalsListJSON = DataResources.chemicalsListJSON

    init() {
        storageService = ClaysGlazeLocalStorageService()
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let storageService = storageService else {
            return
        }
        storageService.getData(resource: chemicalsListJSON) { [weak self] (chemicals: [Chemical]) in
            self?.chemicalsList = chemicals
        }
        completion()
    }

    func numberOfRowsInSection() -> Int {
        return chemicalsList.count
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> ChemicalsListCellViewModelType? {

        let item = chemicalsList[indexPath.row].name

        return ChemicalsListCellViewModel(item: item)
    }

    func itemToPass() -> Chemical {
        guard let selectedIndexPath = selectedIndexPath else {
            return Chemical(name: "", content: ["":0.0], formula: ["": 0.0])
        }
        return chemicalsList[selectedIndexPath.row]
    }

}

