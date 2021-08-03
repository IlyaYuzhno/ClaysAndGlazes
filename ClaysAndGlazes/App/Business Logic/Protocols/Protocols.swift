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

// MARK: - Clays part protocols

// ClaysTableView
protocol ClaysTableViewViewModelType {
    var claysList: [String] { get }
    var filteredClaysList: [String] { get set }
    var claysInfo: [String] { get }
    var claysInfoDictionary: [String: String] { get }
    var sections: [Section] { get set }
    var isSearching: Bool { get set }
    var interactor: Interactor? { get set }
    var presenter: ClaysTableViewPresenterType? { get set }

    func numberOfSections() -> Int
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClayCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> TemperatureTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}

// ClaysTableViewPresenter
protocol ClaysTableViewPresenterType: AnyObject {
    var interactor: Interactor? { get set }
    func present(completion: @escaping ([Section], [String], [String], [String], [String : String]) -> Void)
}

// TemperatureTableView
protocol TemperatureTableViewViewModelType {
    var temperatures: [String] { get set }
    var interactor: Interactor? { get set }
    var mode: String? { get set}
    var item: String { get set }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> CrackleTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func mode(mode: String)
}

// CrackleTableView
protocol CrackleTableViewViewModelType {
    var interactor: Interactor { get set }
    var crackle: [String] { get }
    var clay: String { get }
    var glaze: String { get }
    var temperature: String { get }
    var mode: String { get }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func viewModelForGlazesForClay(clay: String, temperature: String, crackleId: String) -> GlazesForClayTableViewViewModelType?
    func viewModelForClaysForGlaze(glaze: String, temperature: String, crackleId: String) -> ClaysForGlazesTableViewViewModelType?
}

// Glazes for clay TableView
protocol GlazesForClayTableViewViewModelType {
    var interactor: Interactor? { get set }
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

protocol GlazeTemperatureTableViewViewModelType {
    var temperatures: [String] { get set }
    var interactor: Interactor? { get set }
    var mode: String? { get set}
    var item: String { get set }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> CrackleTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func mode(mode: String)
}
