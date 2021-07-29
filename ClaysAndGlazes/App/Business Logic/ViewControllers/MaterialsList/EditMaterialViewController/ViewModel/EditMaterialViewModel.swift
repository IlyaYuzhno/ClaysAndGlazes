//
//  EditMaterialViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 28.07.2021.
//

import Foundation

class EditMaterialViewModel: EditMaterialViewModelType {

    var material: Material

    init(material: Material) {
        self.material = material
    }

    var name: String {
        return material.name
    }

    var quantity: String {
        return material.quantity
    }

    var info: String {
        return material.info
    }

    var type: String {
        return material.type
    }

    var marked: Bool {
        return material.marked
    }

    func getMaterial() -> Material {
        return material
    }

}
