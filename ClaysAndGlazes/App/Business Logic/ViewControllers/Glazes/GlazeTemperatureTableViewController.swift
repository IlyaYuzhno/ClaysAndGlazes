//
//  GlazeTemperatureTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 14.04.2021.
//

import UIKit

class GlazeTemperatureTableViewController: UITableViewController {

    let interactor: Interactor
    var temperatures: [String] = []
    var glaze = ""

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
        title =  "ГЛАЗУРЬ \(glaze)"
        tableView.backgroundColor = .BackgroundColor1
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "glazeTemperaturesTableView"
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "glazeTemperatureCell")

        // Get temperatures array for glaze
        interactor.getGlazeTemperature(for: glaze) { [weak self] temps in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "glazeTemperatureCell", for: indexPath) as! DefaultCell
        cell.accessibilityIdentifier = "glazeTemperatureCell"
        cell.configure(item: temperatures[indexPath.row].description)
        return cell
    }

    // MARK: Go to next VC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crackleViewController = CrackleTableViewController(interactor: interactor, mode: "glaze")
        crackleViewController.glaze = glaze
        crackleViewController.temperature = temperatures[indexPath.row].description
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
