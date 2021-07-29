//
//  Protocols.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation


// MARK: - MaterialsView protocols

// MaterialsTableView
protocol MaterialsListTableViewViewModelType {
    func numberOfSections() -> Int
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MaterialsTableViewCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func deleteItem(forIndexPath indexPath: IndexPath)
    func markItem(forIndexPath indexPath: IndexPath)

    func viewModelForSelectedRow() -> EditMaterialViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)

    var sections: [Section] { get set }
}

// MaterialsTableView Cell
protocol MaterialsTableViewCellViewModelType: AnyObject {
    var name: String { get }
    var info: String { get }
    var quantity: String { get }
    var marked: Bool { get }
}

// EditMaterialsView
protocol EditMaterialViewModelType {
    var name: String { get }
    var quantity: String { get }
    var info: String { get  }
    var type: String { get }
    var marked: Bool { get }
    func getMaterial() -> Material
}

// AddMaterialsView
protocol AddMaterialViewControllerViewModelType {
     func addNewMaterial(type: String, quantity: String, name: String, info: String)
}

