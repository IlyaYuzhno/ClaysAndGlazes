//
//  GlazesTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit

class GlazesForClayTableViewController: UITableViewController {

    var viewModel: GlazesForClayTableViewViewModelType?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ПОДХОДЯЩИЕ ГЛАЗУРИ"
        tableView.backgroundColor = .BackgroundColor1
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "glazesTableView"
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "glazesCell")

        // Load data via viewModel
        viewModel?.loadData(completion: { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(forSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glazesCell", for: indexPath) as? DefaultCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        tableViewCell.accessibilityIdentifier = "glazesCell"
        return tableViewCell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil }

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "glazesViewHeader") as? DefaultHeader ?? DefaultHeader(reuseIdentifier: "glazesViewHeader")
        header.titleLabel.font = .boldSystemFont(ofSize: 22)
        header.titleLabel.text = "Глазури \(viewModel.brand[section]):"
        return header
    }
}
