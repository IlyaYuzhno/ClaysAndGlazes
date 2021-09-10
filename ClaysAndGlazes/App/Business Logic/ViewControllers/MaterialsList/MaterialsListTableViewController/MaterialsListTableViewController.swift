//
//  MaterialsListTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import UIKit

class MaterialsListTableViewController: UITableViewController {

    var viewModel: MaterialsListTableViewViewModelType?
    var isCollapsed: [String : Bool] = [:]

    var addToPurchaseListView: AddItemsToPurchaseListView = {
        let view = AddItemsToPurchaseListView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "")
        return view
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MaterialsListViewModel()
        viewModel?.delegate = self
        setupTableView()
    }

    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    // MARK: - Load materials data
    func loadData() {
        viewModel?.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.viewModel?.addItemsToPurchaseListIfZeroQuantity()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel?.numberOfSections() ?? 0 > 0 {
            tableView.backgroundView = nil
            return viewModel?.numberOfSections() ?? 0
        } else {
            viewModel?.showEmptyTablePlaceholder(tableView: self.tableView)
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection(forSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "materialCell", for: indexPath) as? MaterialCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)

        tableViewCell.viewModel = cellViewModel

        return tableViewCell
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
            self?.viewModel?.markItem(forIndexPath: indexPath)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self?.loadData()
            }
            success(true)
        })

        markAction.backgroundColor = .BackgroundColor2
        let configuration =  UISwipeActionsConfiguration(actions: [markAction])
        return configuration
    }

    // MARK: - Delete the Material Item and table row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let viewModel = viewModel else { return }
            viewModel.deleteItem(forIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            loadData()
        }
    }

    // MARK: - Tap on item to edit
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)

        // Go to Edit Material VC
        let editMaterialViewController = EditMaterialViewController()

        editMaterialViewController.viewModel = viewModel.viewModelForSelectedRow()
        
        self.navigationController?.pushViewController(editMaterialViewController, animated: true)
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = viewModel?.sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(collapsed: (viewModel?.sections[section].collapsed)!)
        header.section = section
        header.delegate = self
        return header
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (viewModel?.sections[(indexPath as NSIndexPath).section].collapsed)! ? 0 : UITableView.automaticDimension
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
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }
}

// MARK: Collapse or not collapse sections
extension MaterialsListTableViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {

        let collapsed = !(viewModel?.sections[section].collapsed ?? false)

        // Toggle collapse
        viewModel?.sections[section].collapsed = collapsed

        // Get section name
        guard let sectionName = viewModel?.sections[section].name else { return }

        // Set isCollapsed dictionary value for section name and save it, i.e. store section state
        isCollapsed[sectionName] = collapsed
        LocalStorageService.genericSave(object: isCollapsed, key: "isCollapsed")

        header.setCollapsed(collapsed: collapsed)
        tableView.setContentOffset(.zero, animated: true)

        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .fade)
    }
    
}

// MARK: - Show and hide AddToPurchaseListView if any material is 0
extension MaterialsListTableViewController: MaterialsListViewModelDelegate {
    func reloadDataSource() {
        loadData()
        hideAddToPurchaseListView()
    }

    func showAddToPurchaseListView() {
        view.addSubview(addToPurchaseListView)

        addToPurchaseListView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToPurchaseListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        addToPurchaseListView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        addToPurchaseListView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        addToPurchaseListView.delegate = viewModel as? AddItemsToPurchaseListViewDelegate
    }

    func hideAddToPurchaseListView() {
        addToPurchaseListView.removeFromSuperview()
    }


}
