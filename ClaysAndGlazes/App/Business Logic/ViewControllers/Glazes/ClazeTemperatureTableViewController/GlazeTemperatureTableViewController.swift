//
//  GlazeTemperatureTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 14.04.2021.
//

import UIKit

class GlazeTemperatureTableViewController: UITableViewController {

    var viewModel: GlazeTemperatureTableViewViewModelType?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "ГЛАЗУРЬ \(viewModel?.item ?? "")"
        tableView.backgroundColor = .BackgroundColor1
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "glazeTemperaturesTableView"
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "glazeTemperatureCell")

        // Get temperatures array for glaze via viewModel
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "glazeTemperatureCell", for: indexPath) as? DefaultCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        tableViewCell.accessibilityIdentifier = "glazeTemperatureCell"
        return tableViewCell
    }

    // MARK: Go to next CrackleTableVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        viewModel.selectRow(atIndexPath: indexPath)
        viewModel.mode(mode: .glaze)

        let crackleViewController = CrackleTableViewController()

        crackleViewController.viewModel = viewModel.viewModelForSelectedRow()

        self.navigationController?.pushViewController(crackleViewController, animated: true)
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "glazeTemperatureViewHeader") as? DefaultHeader ?? DefaultHeader(reuseIdentifier: "glazeTemperatureViewHeader")
        header.titleLabel.text = "Выбери температуру обжига глазури:"
        return header
    }
}
