//
//  PurchaseListTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.09.2021.
//

import UIKit

class PurchaseListTableViewController: UITableViewController {

    var viewModel: PurchaseListTableViewViewModelType?
    var addManuallyView: AddItemToPurchaseListManuallyView?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PurchaseListTableViewViewModel()
        setupTableView()

        loadData()
    }

    func loadData() {
        viewModel?.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel?.numberOfRowsInSection(forSection: section) ?? 0) > 0 {
            tableView.backgroundView = nil
            return viewModel?.numberOfRowsInSection(forSection: section) ?? 0
        } else {
            viewModel?.showEmptyTablePlaceholder(tableView: self.tableView)
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseListCell", for: indexPath) as? DefaultCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)

        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }

    // MARK: - Delete the purchase list item and table row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let viewModel = viewModel else { return }
            viewModel.deleteItem(forIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            loadData()
        }
    }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "КУПЛЕНО"
    }

    // MARK: - Setup TableView
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "СПИСОК ПОКУПОК"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "purchaseListTableView"
        clearsSelectionOnViewWillAppear = true
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "purchaseListCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }

    @objc func addButtonTapped() {
        addManuallyView = AddItemToPurchaseListManuallyView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), text: "")
        guard let addItemView = addManuallyView else { return }

        view.addSubview(addItemView)
        Animation.setBlur(view: self.view, contentView: addItemView)

        addItemView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addItemView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        addItemView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        addItemView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true

        addItemView.delegate = self
    }

}

extension PurchaseListTableViewController: AddItemToPurchaseListManuallyViewDelegate {

    func okButtonTapped() {
        loadData()
        addManuallyView?.removeFromSuperview()
        Animation.removeBlur()
    }

    func cancelButtonTapped() {
        addManuallyView?.removeFromSuperview()
        Animation.removeBlur()
    }
}
