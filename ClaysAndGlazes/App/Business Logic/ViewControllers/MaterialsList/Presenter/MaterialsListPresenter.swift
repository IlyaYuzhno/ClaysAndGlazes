//
//  MaterialsListPresenter.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.07.2021.
//

import UIKit

final class MaterialsListPresenter: UITableViewController {

    class func present(completion: @escaping ([Section]) -> Void) {

    LocalStorageService.retrieve() { materials in

        var sections: [Section] = []

        let sectionNames = materials.map { $0.map { $0.type }}?.removingDuplicates()  ?? [""]

        (0..<sectionNames.count).forEach { i in

            let items = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.name }} ?? [""]
            let quantity = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.quantity }} ?? [""]
            let info = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.info }} ?? [""]
            let marked = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.marked }} ?? [false]

            let section = Section(name: sectionNames[i], items: items, info: info, quantity: quantity, marked: marked)
            sections.append(section)
        }
        LocalStorageService.genericSave(object: sections, key: "Sections")
        completion(sections)
    }
}



}


