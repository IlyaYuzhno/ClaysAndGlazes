//
//  ClayTemperatureTableViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

class ClayTemperatureTableViewViewModel: TemperatureTableViewViewModelType {

    var temperatures: [String] = []
    var interactor: ClaysGlazeLocalStorageService?
    var mode: String?
    var item: String
    private var selectedIndexPath: IndexPath?

    init(interactor: ClaysGlazeLocalStorageService, item: String) {
        self.interactor = interactor
        self.item = item
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return temperatures.count
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func mode(mode: String) {
        self.mode = mode
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = temperatures[indexPath.row]
        
        return DefaultCellViewModel(item: item)
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let interactor = interactor else { return }

        interactor.getClayTemperature(for: item) { [weak self] temps in
            self?.temperatures = temps
            completion()
        }
    }

    func viewModelForSelectedRow() -> CrackleTableViewViewModelType? {
        guard let selectedIndexPath = self.selectedIndexPath, let interactor = interactor else { return nil}

        let temperature = temperatures[selectedIndexPath.row].description

        return CrackleTableViewViewModel(interactor: interactor, clay: item , glaze: "", temperature: temperature, mode: mode ?? "")
    }
}

