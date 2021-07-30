//
//  GlazesTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

protocol GlazesTableViewViewModelType {
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

class GlazesTableViewViewModel: GlazesTableViewViewModelType {

    var interactor: Interactor?
    var clay: String
    var temperature: String
    var crackleId: String
    var glazes: [String] = []
    var brand: [String] = []

    init(interactor: Interactor, clay: String, temperature: String, crackleId: String) {
        self.interactor = interactor
        self.clay = clay
        self.temperature = temperature
        self.crackleId = crackleId
    }

    func numberOfSections() -> Int {
        return brand.count
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return glazes.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = glazes[indexPath.row]
        return DefaultCellViewModel(item: item)
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let interactor = interactor else { return }

        let serialQueue = DispatchQueue(label: "com.queue.Serial")
        serialQueue.sync {

        // Get glazes
        interactor.getGlazes(for: clay, temperature: temperature, crackleId: self.crackleId) { [weak self] items in
                self?.glazes = items
            }
        }

        // Get glazes brand
        interactor.getGlazesBrand(for: glazes.first ?? "") { [weak self] brand in
            self?.brand = brand
            completion()
        }
    }
}
