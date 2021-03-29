//
//  ClaysTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit

class ClaysTableViewController: UITableViewController {

    var clays: [String] = []
    let interactor: Interactor

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
        title = "ВЫБЕРИ ГЛИНУ"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "claysTableView"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // Get clays array
        interactor.getClays() { [weak self] clays in
            self?.clays = clays
            self?.tableView.reloadData()
        }


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clays.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.accessibilityIdentifier = "clayCell"
        
        cell.textLabel?.text = clays[indexPath.row]

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let temperatureViewController = TemperatureTableViewController(interactor: interactor)
        temperatureViewController.clay = clays[indexPath.row]
        self.navigationController?.show(temperatureViewController, sender: self)

    }



}
