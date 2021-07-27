//
//  MaterialsListTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import UIKit

class MaterialsListTableViewController: UITableViewController {

    var sections: [Section] = []
    var isCollapsed: [String : Bool] = [:]

   // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        // Load sections with data
        loadData()


    }

    // MARK: - Load materials data
    private func loadData() {
        MaterialsListPresenter.present() { [weak self] sections in
            self?.sections = sections
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].collapsed ? 0 : sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "materialCell", for: indexPath) as! MaterialCell

        let name = sections[indexPath.section].items[indexPath.row]
        let info = sections[indexPath.section].info[indexPath.row]
        let quantity = sections[indexPath.section].quantity?[indexPath.row] ?? ""
        let marked = sections[indexPath.section].marked?[indexPath.row] ?? false

        cell.configure(name: name, info: info, quantity: quantity, marked: marked)

        return cell
    }

    // MARK: - Table view delegate

    // True for enabling the editing mode
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
        }

    // MARK: - Leading swipe handler - mark the Material item cell
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAction = UIContextualAction(style: .normal, title: "Отметить", handler:{ [weak self] (_, _, success) in

            // Mark or unmark the cell
            self?.mark(indexPath: indexPath)

            success(true)
        })

        markAction.backgroundColor = .BackgroundColor2
        let configuration =  UISwipeActionsConfiguration(actions: [markAction])
        return configuration
    }

    // MARK: - Delete the Material Item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

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

            tableView.deleteRows(at: [indexPath], with: .fade)
            loadData()
        }
    }

    // MARK: - Tap on item to edit
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        guard let currentCell = tableView.cellForRow(at: indexPath) as? MaterialCell else { return }

        let name = currentCell.nameLabel.text ?? ""
        let info = currentCell.infoLabel.text ?? ""
        let quantity = currentCell.quantityLabel.text ?? ""
        let type = sections[indexPath.section].name
        let marked = sections[indexPath.section].marked?[indexPath.row] ?? false

        let itemToRemove = Material(type: type, name: name, quantity: quantity, info: info, marked: marked)

        // Go to edit material VC
        let editMaterialViewController = EditMaterialViewController(itemToRemove: itemToRemove)

        editMaterialViewController.title = ("Исправляем \(name)")
        
        self.navigationController?.pushViewController(editMaterialViewController, animated: true)
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(collapsed: sections[section].collapsed)
        header.section = section
        header.delegate = self
        return header
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return sections[(indexPath as NSIndexPath).section].collapsed ? 0 : UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         60
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    // MARK: - Setup TableView
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "СПИСОК МАТЕРИАЛОВ"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "materialsListTableView"
        clearsSelectionOnViewWillAppear = true
        tableView.register(MaterialCell.self, forCellReuseIdentifier: "materialCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }

    // MARK: - Add Item Button tapped
    @objc func addItemTapped() {
        // Go to add material VC
        let addMaterialViewController = AddMaterialViewController()
        self.navigationController?.pushViewController(addMaterialViewController, animated: true)
    }

    // MARK: - Mark the cell
    private func mark(indexPath: IndexPath) {

        // Get current material
        let name = self.sections[indexPath.section].items[indexPath.row]
        let info = self.sections[indexPath.section].info[indexPath.row]
        let quantity = self.sections[indexPath.section].quantity?[indexPath.row] ?? ""
        let type = self.sections[indexPath.section].name
        let marked = self.sections[indexPath.section].marked?[indexPath.row] ?? false

        // Create marked material
        var markedMaterial = Material(type: type, name: name, quantity: quantity, info: info, marked: marked)

        // Remove unmarked material from storage
        let itemToRemove = markedMaterial
        LocalStorageService.removeItemFromDataSource(itemToRemove: itemToRemove)

        // Check if material marked or not
        markedMaterial.marked = markedMaterial.marked ? false : true

        // Save marked Material to storage
        LocalStorageService.save(object: markedMaterial)

        // Reload data
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.loadData()
        }
    }

}

// MARK: Collapse or not collapse sections
extension MaterialsListTableViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed

        // Toggle collapse
        sections[section].collapsed = collapsed

        // Set isCollapsed dictionary values and save it - store section collapse state
        isCollapsed[sections[section].name] = collapsed
        LocalStorageService.genericSave(object: isCollapsed, key: "isCollapsed")

        header.setCollapsed(collapsed: collapsed)
        tableView.setContentOffset(.zero, animated: true)

        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .fade)
    }
}
