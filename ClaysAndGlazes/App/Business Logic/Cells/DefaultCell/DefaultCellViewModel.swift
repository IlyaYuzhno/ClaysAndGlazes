//
//  DefaultCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import Foundation

protocol DefaultCellViewModelType: AnyObject {
    var text: String { get }
}

class DefaultCellViewModel: DefaultCellViewModelType {

    private var item: String

    var text: String {
        return item
    }

    init(item: String) {
        self.item = item
    }

}
