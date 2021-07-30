//
//  TemperatureTableViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

protocol TemperatureTableViewViewModelType {
    var temperatures: [String] { get set }
    var interactor: Interactor? { get set }
    var mode: String? { get set}
    var clay: String { get set }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(forClay clay:String, completion: (@escaping () -> ()?))
    func viewModelForSelectedRow() -> CrackleTableViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func getValues(mode: String)
}

class TemperatureTableViewViewModel: TemperatureTableViewViewModelType {

    var temperatures: [String] = []
    var interactor: Interactor?
    var mode: String?
    var clay: String
    private var selectedIndexPath: IndexPath?

    init(interactor: Interactor, clay: String) {
        self.interactor = interactor
        self.clay = clay
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return temperatures.count
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func getValues(mode: String) {
        self.mode = mode
       // self.clay = clay
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = temperatures[indexPath.row]
        
        return DefaultCellViewModel(item: item)
    }

    func loadData(forClay clay:String, completion: @escaping (() -> ()?)) {
        guard let interactor = interactor else { return }

        interactor.getTemperature(for: clay) { [weak self] temps in
            self?.temperatures = temps
            completion()
        }
    }

    func viewModelForSelectedRow() -> CrackleTableViewViewModelType? {
        guard let selectedIndexPath = self.selectedIndexPath else { return nil}

        let temperature = temperatures[selectedIndexPath.row].description

        return CrackleTableViewViewModel(clay: clay , glaze: "", temperature: temperature, mode: mode ?? "")
    }
}

