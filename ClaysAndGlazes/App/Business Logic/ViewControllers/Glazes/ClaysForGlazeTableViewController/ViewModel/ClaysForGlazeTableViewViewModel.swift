//
//  ClaysForGlazesTableViewViewModelType.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.08.2021.
//

import Foundation

class ClaysForGlazesTableViewViewModel: ClaysForGlazesTableViewViewModelType {

    var storageService: ClaysGlazeLocalStorageService?
    var glaze: String
    var temperature: String
    var crackleId: String
    var clays: [String] = []
    var brand: [String] = []
    let glazesBasicJSON = "GlazesInfo"

    init(storageService: ClaysGlazeLocalStorageService, glaze: String, temperature: String, crackleId: String) {
        self.storageService = storageService
        self.glaze = glaze
        self.temperature = temperature
        self.crackleId = crackleId
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return clays.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = clays[indexPath.row]
        return DefaultCellViewModel(item: item)
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let storageService = storageService else { return }

        storageService.getItemsForSelectedItem(resource: glazesBasicJSON, for: glaze, temperature: temperature, crackleId: crackleId) { [weak self] clays in
            self?.clays = clays
            completion()
        }

        

//        storageService.getClaysForGlaze(for: glaze, temperature: temperature, crackleId: crackleId) { [weak self] clays in
//            self?.clays = clays
//        }
//        completion()
    }

}
