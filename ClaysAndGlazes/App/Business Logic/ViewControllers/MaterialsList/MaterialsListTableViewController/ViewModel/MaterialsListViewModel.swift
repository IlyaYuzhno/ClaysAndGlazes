//
//  MaterialsListViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 28.07.2021.
//

import Foundation

class MaterialsListViewModel: MaterialsListTableViewViewModelType {

    private var selectedIndexPath: IndexPath?

    var sections: [Section] = []

    func loadData(completion: (@escaping () -> ()?)) {
        MaterialsListPresenter.present() { [weak self] sections in
                self?.sections = sections
                completion()
        }
    }

    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> MaterialsTableViewCellViewModelType? {

        let name = sections[indexPath.section].items[indexPath.row]
        let info = sections[indexPath.section].info[indexPath.row]
        let quantity = sections[indexPath.section].quantity?[indexPath.row] ?? ""
        let marked = sections[indexPath.section].marked?[indexPath.row] ?? false

        let material = Material(type: "", name: name, quantity: quantity, info: info, marked: marked)

        return MaterialTableViewCellViewModel(material: material)
    }

    func deleteItem(forIndexPath indexPath: IndexPath) {

        let name = sections[indexPath.section].items[indexPath.row] 
        let info = sections[indexPath.section].info[indexPath.row] 
        let quantity = sections[indexPath.section].quantity?[indexPath.row] ?? ""
        let type = sections[indexPath.section].name 
        let marked = sections[indexPath.section].marked?[indexPath.row] ?? false

        let itemToRemove = Material(type: type, name: name, quantity: quantity, info: info, marked: marked)

        // Remove deleted item and save edited datasource to UserDefaults
        LocalStorageService.removeItemFromDataSource(itemToRemove: itemToRemove)

        // Delete the row from the data source
        sections[indexPath.section].info.remove(at: indexPath.row)
        sections[indexPath.section].items.remove(at: indexPath.row)
        sections[indexPath.section].quantity?.remove(at: indexPath.row)
        sections[indexPath.section].marked?.remove(at: indexPath.row)

    }

    func markItem(forIndexPath indexPath: IndexPath) {

        // Get current material
        let name = sections[indexPath.section].items[indexPath.row]
        let info = sections[indexPath.section].info[indexPath.row]
        let quantity = sections[indexPath.section].quantity?[indexPath.row] ?? ""
        let type = sections[indexPath.section].name
        let marked = sections[indexPath.section].marked?[indexPath.row] ?? false

        // Create marked material
        var markedMaterial = Material(type: type, name: name, quantity: quantity, info: info, marked: marked)

        // Remove unmarked material from storage
        let itemToRemove = markedMaterial
        LocalStorageService.removeItemFromDataSource(itemToRemove: itemToRemove)

        // Check if material marked or not
        markedMaterial.marked = markedMaterial.marked ? false : true

        // Save marked Material to storage
        LocalStorageService.save(object: markedMaterial)

    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func viewModelForSelectedRow() -> EditMaterialViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }

        let name = sections[selectedIndexPath.section].items[selectedIndexPath.row]
        let info = sections[selectedIndexPath.section].info[selectedIndexPath.row]
        let quantity = sections[selectedIndexPath.section].quantity?[selectedIndexPath.row] ?? ""
        let type = sections[selectedIndexPath.section].name
        let marked = sections[selectedIndexPath.section].marked?[selectedIndexPath.row] ?? false

        let itemToEdit = Material(type: type, name: name, quantity: quantity, info: info, marked: marked)

        return EditMaterialViewModel(material: itemToEdit)
    }

}
