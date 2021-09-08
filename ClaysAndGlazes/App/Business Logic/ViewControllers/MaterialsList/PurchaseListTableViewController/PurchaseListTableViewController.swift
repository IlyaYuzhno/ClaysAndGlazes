//
//  PurchaseListTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.09.2021.
//

import UIKit

class PurchaseListTableViewController: UITableViewController {

    var viewModel: PurchaseListTableViewViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PurchaseListTableViewViewModel()
        setupTableView()

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

    // MARK: - Setup TableView
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "СПИСОК ПОКУПОК"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "materialsListTableView"
        clearsSelectionOnViewWillAppear = true
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "purchaseListCell")
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }

}
