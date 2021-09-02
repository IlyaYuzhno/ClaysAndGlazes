//
//  MateriaTableViewCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 28.07.2021.
//

import Foundation

class MaterialTableViewCellViewModel: MaterialsTableViewCellViewModelType {

    private var material: Material

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

    init(material: Material) {
        self.material = material
    }

}
