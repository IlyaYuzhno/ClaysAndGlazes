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
        title =  "\(clay)" //"ТЕМПЕРАТУРА ОБЖИГА ГЛАЗУРИ"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "temperaturesTableView"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // Get temperatures array for clay
        interactor.getTemperature(for: clay) { [weak self] temps in
            self?.temperatures = temps
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperatures.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.accessibilityIdentifier = "temperatureCell"

        cell.textLabel?.text = temperatures[indexPath.row].description

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let crackleViewController = CrackleTableViewController(interactor: interactor)
        crackleViewController.clay = clay
        crackleViewController.temperature = temperatures[indexPath.row].description
        self.navigationController?.show(crackleViewController, sender: self)

    }


}
