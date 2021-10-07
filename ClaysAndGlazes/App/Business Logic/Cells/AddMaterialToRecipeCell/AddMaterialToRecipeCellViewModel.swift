//
//  AddMaterialToRecipeCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 07.10.2021.
//

import Foundation

protocol AddMaterialToRecipeCellViewModelType: AnyObject {
    var text: String { get }
}

class AddMaterialToRecipeCellViewModel: AddMaterialToRecipeCellViewModelType {

    private var item: String

    var text: String {
        return item
    }

    init(item: String) {
        self.item = item
    }

}
