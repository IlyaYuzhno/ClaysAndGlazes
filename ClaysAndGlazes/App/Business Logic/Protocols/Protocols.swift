//
//  Protocols.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation
import UIKit


// MARK: - MaterialsView protocols

// MaterialsTableView
protocol MaterialsListTableViewViewModelType {
    var delegate: MaterialsListViewModelDelegate? { get set }
    func numberOfSections() -> Int
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MaterialsTableViewCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func deleteItem(forIndexPath indexPath: IndexPath)
    func markItem(forIndexPath indexPath: IndexPath)
    func viewModelForSelectedRow() -> EditMaterialViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    var sections: [Section] { get set }
    func showEmptyTablePlaceholder(tableView: UITableView)
    func addItemsToPurchaseListIfZeroQuantity()
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
    var quantity: Float { get }
    var info: String { get  }
    var type: String { get }
    var marked: Bool { get }
    var unit: String { get }
    func getMaterial() -> MaterialItem
    func editMaterial(itemName: String, itemQuantity: Float, itemInfo: String)
}

// AddMaterialsView
protocol AddMaterialViewControllerViewModelType {
    var pickerItems: [String] { get }
    var unitsDropDownListOptions: [String] { get }

    func addNewMaterial(type: String, quantity: String, unit: String, name: String, info: String, viewController: UIViewController)
}

// MARK: - Clays part protocols

// ClaysTableView
protocol ClaysTableViewViewModelType {
    var claysList: [String] { get }
    var filteredClaysList: [String] { get set }
    var claysInfo: [String] { get }
    var claysInfoDictionary: [String: String] { get }
    var sections: [Section] { get set }
    var isSearching: Bool { get set }
    var storageService: ClaysGlazeLocalStorageService? { get set }
    var presenter: ClaysTableViewPresenterType? { get set }

    func numberOfSections() -> Int
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClayCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> TemperatureTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func viewModelForInformationView() -> InformationViewViewModelType?
}

// ClaysTableViewPresenter
protocol ClaysTableViewPresenterType: AnyObject {
    var storageService: ClaysGlazeLocalStorageService? { get set }
    func present(completion: @escaping ([Section], [String], [String], [String], [String : String]) -> Void)
}

// TemperatureTableView
protocol TemperatureTableViewViewModelType {
    var temperatures: [String] { get set }
    var storageService: ClaysGlazeLocalStorageService? { get set }
    var mode: Mode? { get set}
    var item: String { get set }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> CrackleTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func mode(mode: Mode)
}

// CrackleTableView
protocol CrackleTableViewViewModelType {
    var storageService: ClaysGlazeLocalStorageService { get set }
    var crackle: [String] { get }
    var clay: String { get }
    var glaze: String { get }
    var temperature: String { get }
    var mode: Mode { get }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func viewModelForGlazesForClay(clay: String, temperature: String, crackleId: String) -> GlazesForClayTableViewViewModelType?
    func viewModelForClaysForGlaze(glaze: String, temperature: String, crackleId: String) -> ClaysForGlazesTableViewViewModelType?
}

// Glazes for clay TableView
protocol GlazesForClayTableViewViewModelType {
    var storageService: ClaysGlazeLocalStorageService? { get set }
    var clay: String { get }
    var temperature: String { get }
    var crackleId: String { get }
    var glazes: [String] { get }
    var brand: [String]{ get }
    func numberOfSections() -> Int
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
}


// MARK: - Glazes part protocols

// Glazes TableView
protocol ChooseGlazeTableViewViewModelType {
    var itemsList: [String] { get }
    var filteredItemsList: [String] { get set }
    var itemsInfo: [String] { get }
    var itemsInfoDictionary: [String: String] { get }
    var sections: [Section] { get set }
    var isSearching: Bool { get set }
    var storageService: ClaysGlazeLocalStorageService? { get set }
    var presenter: ClaysTableViewPresenterType? { get set }

    func numberOfSections() -> Int
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClayCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> GlazeTemperatureTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func viewModelForInformationView() -> InformationViewViewModelType?
}

// Glazes temperatures
protocol GlazeTemperatureTableViewViewModelType {
    var temperatures: [String] { get set }
    var storageService: ClaysGlazeLocalStorageService? { get set }
    var mode: Mode? { get set}
    var item: String { get set }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> CrackleTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func mode(mode: Mode)
}

// ClaysForGlazeTableView
protocol ClaysForGlazesTableViewViewModelType {
    var storageService: ClaysGlazeLocalStorageService? { get set }
    var glaze: String { get }
    var temperature: String { get }
    var crackleId: String { get }
    var clays: [String] { get }
    var brand: [String]{ get }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
}

// MARK: - Information View ViewModel protocol
protocol InformationViewViewModelType {
    var itemName: String { get }
    var itemInfo: String { get }
    var mode: String { get }
}

// MARK: - Used Material View ViewModel protocol
protocol UsedMaterialViewViewModelType {
    var dropDownItemsArray: [String] { get }
    var materialsDictionary: [String : MaterialItem] { get }
    func loadData(view: UsedMaterialView)
    func saveButtonTapped(stack: UIStackView, self: UIViewController)
}

// MARK: - AddMaterialToPurchaseListManuallyView View ViewModel protocol
protocol AddItemToPurchaseListManuallyViewViewModelType {
    var dropDownItemsArray: [String] { get }
    var selectedText: String { get set }
    func loadData()
}

// MARK: - PurchaseList TableView ViewModel Type
protocol PurchaseListTableViewViewModelType {
    var purchaseList: [String] { get }

    func numberOfRowsInSection(forSection section: Int) -> Int
    func loadData(completion: (@escaping () -> ()?))
    func showEmptyTablePlaceholder(tableView: UITableView)
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func deleteItem(forIndexPath indexPath: IndexPath)
    func selectRow(atIndexPath indexPath: IndexPath)
    func deleteSelectedItems(forIndexPaths set: [IndexPath])
}

// MARK: - Materials Statistic protocols
protocol StatisticControllerType: AnyObject {
    var statisticList: [MaterialStatisticItem] { get set }
    func saveToStatistic(itemToSave: MaterialStatisticItem)
    func loadStatisticData(completion: (@escaping () -> ()?))
}

protocol MaterialsListMainViewViewModelType: AnyObject {
    func loadStatisticData(completion: (@escaping () -> ()?))
    func numberOfRowsInSection(forSection section: Int, tableView: UITableView) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> StatisticTableViewCellViewModelType?
    func viewForHeaderInSection(tableView: UITableView) -> UIView
}

protocol StatisticTableViewCellViewModelType: AnyObject {
    var title: String { get }
    var quantity: String { get }
    var unit: String { get }
}
