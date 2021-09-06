//
//  PurchaseListTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.09.2021.
//

import UIKit


protocol PurchaseListTableViewViewModelType {
    var purchaseList: [String] { get }

    func numberOfRowsInSection(forSection section: Int) -> Int
    func showEmptyTablePlaceholder(tableView: UITableView)
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func deleteItem(forIndexPath indexPath: IndexPath)
    func selectRow(atIndexPath indexPath: IndexPath)

}

class PurchaseListTableViewViewModel: PurchaseListTableViewViewModelType {

    var purchaseList: [String] = ["test1", "test2", "test3", "test4"]
    private var selectedIndexPath: IndexPath?

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return purchaseList.count
    }

    func showEmptyTablePlaceholder(tableView: UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 20.0, y: 0, width: tableView.bounds.size.width - 40.0, height: tableView.bounds.size.height))
        messageLabel.text = "Список пуст"
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = purchaseList[indexPath.row]

        return DefaultCellViewModel(item: item)
    }

    func deleteItem(forIndexPath indexPath: IndexPath) {

//        let name = sections[indexPath.section].items[indexPath.row]
//        let info = sections[indexPath.section].info[indexPath.row]
//        let quantity = sections[indexPath.section].quantity?[indexPath.row] ?? 0
//        let unit = sections[indexPath.section].unit?[indexPath.row] ?? ""
//        let type = sections[indexPath.section].name
//        let marked = sections[indexPath.section].marked?[indexPath.row] ?? false
//
//        let itemToRemove = Material(type: type, name: name, quantity: quantity, unit: unit, info: info, marked: marked)
//
//        // Remove deleted item and save edited datasource to UserDefaults
//        LocalStorageService.removeItemFromDataSource(itemToRemove: itemToRemove)
//
//        // Delete the row from the data source
//        sections[indexPath.section].info.remove(at: indexPath.row)
//        sections[indexPath.section].items.remove(at: indexPath.row)
//        sections[indexPath.section].quantity?.remove(at: indexPath.row)
//        sections[indexPath.section].marked?.remove(at: indexPath.row)

    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }


}
