//
//  ClaysForGlazesTableViewViewModelType.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.08.2021.
//

import Foundation

protocol ClaysForGlazesTableViewViewModelType {
    var interactor: Interactor? { get set }
    var glaze: String { get }
    var temperature: String { get }
    var crackleId: String { get }
    var clays: [String] { get }
    var brand: [String]{ get }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DefaultCellViewModelType?
    func loadData(completion: (@escaping () -> ()?))
}

class ClaysForGlazesTableViewViewModel: ClaysForGlazesTableViewViewModelType {

    var interactor: Interactor?
    var glaze: String
    var temperature: String
    var crackleId: String
    var clays: [String] = []
    var brand: [String] = []

    init(interactor: Interactor, glaze: String, temperature: String, crackleId: String) {
        self.interactor = interactor
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
        guard let interactor = interactor else { return }

        interactor.getClaysForGlaze(for: glaze, temperature: temperature, crackleId: crackleId) { [weak self] clays in
            self?.clays = clays
        }
        completion()
    }



    
}
