//
//  TableViewCellViewModelType.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 28.07.2021.
//

import Foundation

class TableViewCellViewModel: MaterialsTableViewCellViewModelType {

    private var material: Material

    var name: String {
        return material.name
    }

    var info: String {
        return material.info
    }

    var quantity: String {
        return material.quantity
    }

    var marked: Bool {
        return material.marked
    }


    init(material: Material) {
        self.material = material
    }

}