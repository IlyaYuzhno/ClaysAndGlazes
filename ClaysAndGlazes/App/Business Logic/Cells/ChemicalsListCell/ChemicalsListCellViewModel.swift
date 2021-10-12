//
//  ChemicalsListCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 11.10.2021.
//

import Foundation

protocol ChemicalsListCellViewModelType: AnyObject {
    var text: String { get }
}

class ChemicalsListCellViewModel: ChemicalsListCellViewModelType {
    private var item: String

    var text: String {
        return item
    }

    init(item: String) {
        self.item = item
    }
}
