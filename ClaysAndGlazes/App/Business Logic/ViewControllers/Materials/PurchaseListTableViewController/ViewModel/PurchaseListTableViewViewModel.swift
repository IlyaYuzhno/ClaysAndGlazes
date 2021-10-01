//
//  PurchaseListTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.09.2021.
//

import UIKit

class PurchaseListTableViewViewModel: PurchaseListTableViewViewModelType {

    var purchaseList: [String] = []
    private var selectedIndexPath: IndexPath?
    let storageKey = MaterialsLocalStorageKeys.purchaseListKey

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return purchaseList.count
    }

    func loadData(completion: (@escaping () -> ()?)) {
        MaterialsLocalStorageService.retrieveDataFromStorage(key: storageKey, type: String.self) {
            [weak self] purchaseList in
                self?.purchaseList = purchaseList ?? []
                completion()
        }
    }

    func showEmptyTablePlaceholder(tableView: UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 20.0, y: 0, width: tableView.bounds.size.width - 40.0, height: tableView.bounds.size.height))
        messageLabel.text = "Список пуст"
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = purchaseList[indexPath.row]

        return DefaultCellViewModel(item: item)
    }

    func deleteItem(forIndexPath indexPath: IndexPath) {

        let itemToRemove = purchaseList[indexPath.row]

        // Remove deleted item and save edited datasource to UserDefaults
        MaterialsLocalStorageService.removeItemInStorage(itemToRemove: itemToRemove, key: storageKey)

        // Delete the row from the data source
        purchaseList.removeAll(where: { $0 == itemToRemove })
    }

    func deleteSelectedItems(forIndexPaths set: [IndexPath]) {
        var items: [String] = []
        for indexPath in set {
            let itemToRemove = purchaseList[indexPath.row]
            items.append(itemToRemove)
            MaterialsLocalStorageService.removeItemInStorage(itemToRemove: itemToRemove, key: storageKey)
        }
        purchaseList = purchaseList.filter { !items.contains($0) }

    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }


}
