//
//  CrackleTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

class CrackleTableViewViewModel: CrackleTableViewViewModelType {

    internal var crackle = ["Много цека", "Мало цека", "Нет цека"]

    var storageService: ClaysGlazeLocalStorageService
    var clay: String
    var glaze: String
    var temperature: String
    var mode: Mode

    init(storageService: ClaysGlazeLocalStorageService,  clay: String, glaze: String, temperature: String, mode: Mode) {
        self.clay = clay
        self.glaze = glaze
        self.temperature = temperature
        self.mode = mode
        self.storageService = storageService
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return crackle.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = crackle[indexPath.row]

        return DefaultCellViewModel(item: item)
    }

    func viewModelForGlazesForClay(clay: String, temperature: String, crackleId: String) -> GlazesForClayTableViewViewModelType? {

        return GlazesForClayTableViewViewModel(storageService: storageService, clay: clay, temperature: temperature, crackleId: crackleId)
    }

    func viewModelForClaysForGlaze(glaze: String, temperature: String, crackleId: String) -> ClaysForGlazesTableViewViewModelType? {

        return ClaysForGlazesTableViewViewModel(storageService: storageService, glaze: glaze, temperature: temperature, crackleId: crackleId)
    }

}
