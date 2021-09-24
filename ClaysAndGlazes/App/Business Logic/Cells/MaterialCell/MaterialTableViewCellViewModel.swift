//
//  MateriaTableViewCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 28.07.2021.
//

import Foundation

class MaterialTableViewCellViewModel: MaterialsTableViewCellViewModelType {

    private var material: MaterialItem

    var name: String {
        return material.name
    }

    var info: String {
        return material.info
    }

    var quantity: String {
        return String(material.quantity) + " " + material.unit
    }

    var marked: Bool {
        return material.marked
    }

    init(material: MaterialItem) {
        self.material = material
    }

}
