//
//  CrackleTableViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

protocol CrackleTableViewViewModelType {
    var crackle: [String] { get }
    var clay: String { get }
    var glaze: String { get }
    var temperature: String { get }
    var mode: String { get }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func viewModelForSelectedRow(interactor: Interactor, clay: String, temperature: String, crackleId: String) -> GlazesTableViewViewModelType?
}

class CrackleTableViewViewModel: CrackleTableViewViewModelType {

    internal var crackle = ["Много цека", "Мало цека", "Нет цека"]

    var clay: String
    var glaze: String
    var temperature: String
    var mode: String

    init(clay: String, glaze: String, temperature: String, mode: String) {
        self.clay = clay
        self.glaze = glaze
        self.temperature = temperature
        self.mode = mode
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return crackle.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType? {

        let item = crackle[indexPath.row]

        return DefaultCellViewModel(item: item)
    }

    func viewModelForSelectedRow(interactor: Interactor, clay: String, temperature: String, crackleId: String) -> GlazesTableViewViewModelType? {

      return GlazesTableViewViewModel(interactor: interactor, clay: clay, temperature: temperature, crackleId: crackleId)
    }
}
