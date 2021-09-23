//
//  TemperatureTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit

class ClaysTemperatureTableViewController: UITableViewController {

    let interactor: ClaysGlazeLocalStorageService
    var viewModel: TemperatureTableViewViewModelType?

    // MARK: - Init
    init(interactor: ClaysGlazeLocalStorageService) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "МАССА \(viewModel?.item ?? "")"
        tableView.backgroundColor = .BackgroundColor1
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "temperaturesTableView"
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "temperatureCell")

        // Get temperatures array for clay
        viewModel?.loadData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(forSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temperatureCell", for: indexPath) as? DefaultCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        tableViewCell.accessibilityIdentifier = "temperatureCell"
        return tableViewCell
    }

    // MARK: Go to next CrackleTableVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        viewModel.mode(mode: "clay")

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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "temperatureViewHeader") as? DefaultHeader ?? DefaultHeader(reuseIdentifier: "temperatureViewHeader")
        header.titleLabel.text = "Выбери температуру обжига глазури:"
        return header
    }

}
