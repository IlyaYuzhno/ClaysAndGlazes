//
//  ClaysTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.07.2021.
//

import Foundation


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

class ClaysTableViewViewModel: ClaysTableViewViewModelType {

    var interactor: Interactor?
    var presenter: ClaysTableViewPresenterType?
    private var selectedIndexPath: IndexPath?
    var claysList: [String] = []
    var filteredClaysList: [String] = []
    var claysInfo: [String] = []
    var claysInfoDictionary: [String : String] = [:]
    var sections: [Section] = []
    var isSearching = false

    init(interactor: Interactor) {
        self.interactor = interactor
        presenter = ClaysTableViewPresenter(interactor: interactor)
    }

    func numberOfSections() -> Int {
        isSearching ? 1 : sections.count
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        isSearching ? filteredClaysList.count : sections[section].collapsed ? 0 : sections[section].items.count
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClayCellViewModelType? {

        var item = ""

        if isSearching {
            item = filteredClaysList[indexPath.row]
        } else {
            item = sections[indexPath.section].items[indexPath.row]
        }

        return ClayCellViewModel(item: item)
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let presenter = presenter else { return }

        presenter.present() { [weak self] (sections, claysList, claysInfo, filteredClaysList, claysInfoDictionary) in

            self?.sections = sections
            self?.claysList = claysList
            self?.claysInfo = claysInfo
            self?.filteredClaysList = filteredClaysList
            self?.claysInfoDictionary = claysInfoDictionary
        }
        completion()
    }

    func viewModelForSelectedRow() -> TemperatureTableViewViewModelType? {
        guard let interactor = interactor, let selectedIndexPath = selectedIndexPath else { return nil}

        var clay = ""

        if isSearching {
            clay = filteredClaysList[selectedIndexPath.row]
        } else {
            clay = sections[selectedIndexPath.section].items[selectedIndexPath.row]
        }

        return TemperatureTableViewViewModel(interactor: interactor, clay: clay)
    }



}
