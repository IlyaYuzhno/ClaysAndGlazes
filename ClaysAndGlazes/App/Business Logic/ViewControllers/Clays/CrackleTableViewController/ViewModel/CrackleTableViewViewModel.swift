//
//  CrackleTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

class CrackleTableViewViewModel: CrackleTableViewViewModelType {

    internal var crackle = ["Много цека", "Мало цека", "Нет цека"]

    var interactor: Interactor
    var clay: String
    var glaze: String
    var temperature: String
    var mode: String

    init(interactor: Interactor,  clay: String, glaze: String, temperature: String, mode: String) {
        self.clay = clay
        self.glaze = glaze
        self.temperature = temperature
        self.mode = mode
        self.interactor = interactor
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return crackle.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = crackle[indexPath.row]

        return DefaultCellViewModel(item: item)
    }

    func viewModelForGlazesForClay(clay: String, temperature: String, crackleId: String) -> GlazesForClayTableViewViewModelType? {

      return GlazesForClayTableViewViewModel(interactor: interactor, clay: clay, temperature: temperature, crackleId: crackleId)
    }

    func viewModelForClaysForGlaze(glaze: String, temperature: String, crackleId: String) -> ClaysForGlazesTableViewViewModelType? {

        return ClaysForGlazesTableViewViewModel(interactor: interactor, glaze: glaze, temperature: temperature, crackleId: crackleId)
    }

}
