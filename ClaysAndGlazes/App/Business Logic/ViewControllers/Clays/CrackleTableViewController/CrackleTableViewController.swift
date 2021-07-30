//
//  CrackleTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit

class CrackleTableViewController: UITableViewController {

    let interactor: Interactor
    var viewModel: CrackleTableViewViewModelType?

    // MARK: - Init
    init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "НАЛИЧИЕ ЦЕКА"
        tableView.backgroundColor = .BackgroundColor1
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "cracklesTableView"
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "crackleCell")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(forSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crackleCell", for: indexPath) as? DefaultCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        tableViewCell.accessibilityIdentifier = "crackleCell"
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        var crackleId = ""

        switch indexPath.row {
        case 0:
            crackleId = "mnogo"
        case 1:
            crackleId = "malo"
        case 2:
            crackleId = "no"
        default:
            break
        }

        // MARK: Go to next VC
        switch viewModel.mode {
        case "clay":
            let glazesViewController = GlazesTableViewController()

            glazesViewController.viewModel = viewModel.viewModelForSelectedRow(interactor: interactor, clay: viewModel.clay, temperature: viewModel.temperature, crackleId: crackleId)

            self.navigationController?.pushViewController(glazesViewController, animated: true)

        case "glaze":
            let glazeForClaysViewController = GlazeForClaysTableViewController(interactor: interactor)

            glazeForClaysViewController.glaze = viewModel.glaze
            glazeForClaysViewController.temperature = viewModel.temperature
            glazeForClaysViewController.crackleId = crackleId
            
            self.navigationController?.pushViewController(glazeForClaysViewController, animated: true)

        default:
            break
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
}
