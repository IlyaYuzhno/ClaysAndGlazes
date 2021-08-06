//
//  ChooseGlazeTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.07.2021.
//

import Foundation

class ChooseGlazeTableViewViewModel: ChooseGlazeTableViewViewModelType {

    var itemsList: [String] = []
    var filteredItemsList: [String] = []
    var itemsInfo: [String] = []
    var itemsInfoDictionary: [String : String] = [:]
    var sections: [Section] = []
    var isSearching: Bool = false
    var interactor: Interactor?
    var presenter: ClaysTableViewPresenterType?
    private var selectedIndexPath: IndexPath?

    init(interactor: Interactor) {
        self.interactor = interactor
        presenter = ChooseGlazeTableViewPresenter(interactor: interactor)
    }

    func numberOfSections() -> Int {
        isSearching ? 1 : sections.count
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        isSearching ? filteredItemsList.count : sections[section].collapsed ? 0 : sections[section].items.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClayCellViewModelType? {

        var item = ""

        if isSearching {
            item = filteredItemsList[indexPath.row]
        } else {
            item = sections[indexPath.section].items[indexPath.row]
        }

        return ClayCellViewModel(item: item)
        
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let presenter = presenter else { return }

        presenter.present() { [weak self] (sections, glazesList, glazesInfo, filteredGlazesList, glazesInfoDictionary) in

            self?.sections = sections
            self?.itemsList = glazesList
            self?.itemsInfo = glazesInfo
            self?.filteredItemsList = filteredGlazesList
            self?.itemsInfoDictionary =  glazesInfoDictionary
        }
        completion()
    }

    func viewModelForSelectedRow() -> GlazeTemperatureTableViewViewModelType? {
        guard let interactor = interactor, let selectedIndexPath = selectedIndexPath else { return nil}

        var item = ""

        if isSearching {
            item = filteredItemsList[selectedIndexPath.row]
        } else {
            item = sections[selectedIndexPath.section].items[selectedIndexPath.row]
        }

        return GlazeTemperatureTableViewViewModel(interactor: interactor, item: item)
    }


    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }


    func viewModelForInformationView() -> InformationViewViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil}

        var itemName = ""
        var itemInfo = ""

        if isSearching {
            itemName = filteredItemsList[selectedIndexPath.row]
            itemInfo = itemsInfoDictionary[filteredItemsList[selectedIndexPath.row]] ?? ""
        } else {
            itemName = sections[selectedIndexPath.section].items[selectedIndexPath.row]
            itemInfo = sections[selectedIndexPath.section].info[selectedIndexPath.row]
        }

        return InformationViewViewModel(itemName: itemName, itemInfo: itemInfo, mode: "glaze")
    }
}
