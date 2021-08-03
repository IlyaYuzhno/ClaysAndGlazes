//
//  GlazeForClaysTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 14.04.2021.
//

import UIKit

class ClaysForGlazeTableViewController: UITableViewController {

    var viewModel: ClaysForGlazesTableViewViewModelType?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        // Get clays list for chosen glaze via viewModel
        viewModel?.loadData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection(forSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "claysForGlazeCell", for: indexPath) as? DefaultCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        tableViewCell.accessibilityIdentifier = "claysForGlazeCell"

        return tableViewCell
    }

    // MARK: - Private
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "\(viewModel?.glaze ?? "")"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "claysForGlazeTableView"
        clearsSelectionOnViewWillAppear = true
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "claysForGlazeCell")
    }

    // Convert crackle to Russian
    private func crackle(id: String) -> String {
        var crackle = ""
        switch id {
        case "mnogo":
            crackle = "даёт много"
        case "malo":
            crackle =  "даёт мало"
        case "no":
            crackle =  "не даёт"
        default:
            break
        }
        return crackle
    }

    // MARK: - Section header setup
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil }

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "glazeForClaysViewHeader") as? DefaultHeader ?? DefaultHeader(reuseIdentifier: "glazeForClaysViewHeader")
        let x = crackle(id: viewModel.crackleId)
        header.titleLabel.text = "\(viewModel.glaze) на \(viewModel.temperature) \(x) цека для:"
        return header
    }
}
