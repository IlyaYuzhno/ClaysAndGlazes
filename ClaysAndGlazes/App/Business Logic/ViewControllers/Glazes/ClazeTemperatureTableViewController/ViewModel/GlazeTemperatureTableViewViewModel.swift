//
//  GlazeTemperatureTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.08.2021.
//

import Foundation

class GlazeTemperatureTableViewViewModel: GlazeTemperatureTableViewViewModelType {

    var temperatures: [String] = []
    var storageService: ClaysGlazeLocalStorageService?
    var mode: String?
    var item: String
    private var selectedIndexPath: IndexPath?
    let glazesBasicJSON = "GlazesInfo"

    init(storageService: ClaysGlazeLocalStorageService, item: String) {
        self.storageService = storageService
        self.item = item
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return temperatures.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = temperatures[indexPath.row]

        return DefaultCellViewModel(item: item)
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let storageService = storageService else { return }

        storageService.getItemTemperature(resource: glazesBasicJSON, for: item) { [weak self] temps in
            self?.temperatures = temps
            completion()
        }
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func mode(mode: String) {
        self.mode = mode
    }

    func viewModelForSelectedRow() -> CrackleTableViewViewModelType? {
        guard let selectedIndexPath = self.selectedIndexPath, let storageService = storageService else { return nil}

        let temperature = temperatures[selectedIndexPath.row].description

        return CrackleTableViewViewModel(storageService: storageService, clay:"" , glaze: item, temperature: temperature, mode: mode ?? "")
    }

}
