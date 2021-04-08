//
//  TemperatureTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit

class TemperatureTableViewController: UITableViewController {

    let interactor: Interactor
    var temperatures: [String] = []
    var clay = ""

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
        title =  "МАССА \(clay)"
        tableView.backgroundColor = .BackgroundColor1
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "temperaturesTableView"
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "temperatureCell")

        // Get temperatures array for clay
        interactor.getTemperature(for: clay) { [weak self] temps in
            self?.temperatures = temps
            self?.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperatures.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temperatureCell", for: indexPath) as! DefaultCell
        cell.accessibilityIdentifier = "temperatureCell"
        cell.configure(item: temperatures[indexPath.row].description)
        return cell
    }

    // MARK: Go to next VC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crackleViewController = CrackleTableViewController(interactor: interactor)
        crackleViewController.clay = clay
        crackleViewController.temperature = temperatures[indexPath.row].description
        self.navigationController?.pushViewController(crackleViewController, animated: true)

    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
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
