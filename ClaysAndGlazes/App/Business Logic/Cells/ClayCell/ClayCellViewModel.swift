//
//  ClayCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.07.2021.
//

import Foundation


protocol ClayCellViewModelType: AnyObject {
    var text: String { get }
}

class ClayCellViewModel: ClayCellViewModelType {

    private var item: String

    var text: String {
        return item
    }

    init(item: String) {
        self.item = item
    }
}
