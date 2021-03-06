//
//  MaterialsListPresenter.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.07.2021.
//

import Foundation

final class MaterialsListPresenter {

    class func present(completion: @escaping ([Section]) -> Void) {

        MaterialsLocalStorageService.retrieveMaterialsData() { materials, isCollapsed in

        var sections: [Section] = []

        let sectionNames = materials.map { $0.map { $0.type }}?.removingDuplicates() ?? [""]

        (0..<sectionNames.count).forEach { i in

            let items = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.name }} ?? [""]
            let quantity = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.quantity }} ?? []
            let units = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.unit }} ?? [""]
            let info = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.info }} ?? [""]
            let marked = materials.map { $0.filter { $0.type == sectionNames[i] }.map { $0.marked }} ?? [false]

            // Check if section is collapsed or not
            let isCollapsed = isCollapsed[sectionNames[i]] ?? true

            // Create a section
            let section = Section(name: sectionNames[i], items: items, info: info, collapsed: isCollapsed, quantity: quantity, unit: units, marked: marked)

            sections.append(section)
        }
        completion(sections)
    }
}
}


