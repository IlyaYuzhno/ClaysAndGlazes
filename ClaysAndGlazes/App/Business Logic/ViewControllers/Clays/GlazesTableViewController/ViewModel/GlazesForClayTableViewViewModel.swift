//
//  GlazesTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

class GlazesForClayTableViewViewModel: GlazesForClayTableViewViewModelType {

    var storageService: ClaysGlazeLocalStorageService?
    var clay: String
    var temperature: String
    var crackleId: String
    var glazes: [String] = []
    var brand: [String] = []
    let claysBasicJSON = "ClaysInfo"

    init(storageService: ClaysGlazeLocalStorageService, clay: String, temperature: String, crackleId: String) {
        self.storageService = storageService
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
        guard let storageService = storageService else { return }

        let serialQueue = DispatchQueue(label: "com.queue.Serial")
        serialQueue.sync {

            // Get glazes
            storageService.getItemsForSelectedItem(resource: claysBasicJSON, for: clay, temperature: temperature, crackleId: self.crackleId) { [weak self] items in
                self?.glazes = items
            }
        }

        // Get glazes brand
        storageService.getGlazesBrand(for: glazes.first ?? "") { [weak self] brand in
            self?.brand = brand
            completion()
        }
    }
}
