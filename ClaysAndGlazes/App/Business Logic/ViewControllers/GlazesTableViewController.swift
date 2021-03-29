//
//  GlazesTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit

class GlazesTableViewController: UITableViewController {

    let interactor: Interactor
    var clay = ""
    var temperature = ""
    var crackleId = ""
    var glazes: [String] = []

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
        title = "ПОДХОДЯЩИЕ ГЛАЗУРИ"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "glazesTableView"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        // Get glazes
        interactor.getGlazes(for: clay, temp: temperature, crackleId: crackleId) { [weak self] items in
            self?.glazes = items
            self?.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glazes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.accessibilityIdentifier = "glazesCell"

        cell.textLabel?.text = glazes[indexPath.row]
        
        return cell
    }


}
