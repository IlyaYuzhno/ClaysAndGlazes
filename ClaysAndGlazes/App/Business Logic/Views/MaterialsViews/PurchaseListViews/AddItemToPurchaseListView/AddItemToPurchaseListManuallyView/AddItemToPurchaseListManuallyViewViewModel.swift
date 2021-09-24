//
//  AddItemToPurchaseListManuallyViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 10.09.2021.
//

import UIKit

class AddItemToPurchaseListManuallyViewViewModel: AddItemToPurchaseListManuallyViewViewModelType {

    var dropDownItemsArray: [String] = []
    var selectedText = "" {
        didSet {
            saveSelectedItemToPurchaseList()
        }
    }
    let storageKey = MaterialsLocalStorageKeys.purchaseListKey

    func loadData() {
        MaterialsLocalStorageService.retrieveMaterialsData() { [weak self] materials, _ in
            let items = materials.map { $0.map { $0.name }}?.removingDuplicates()
            guard let names = items else { return }
            self?.dropDownItemsArray = names
        }
    }

    private func saveSelectedItemToPurchaseList() {
        MaterialsLocalStorageService.saveDataToStorage(object: selectedText, key: storageKey)
    }

}
