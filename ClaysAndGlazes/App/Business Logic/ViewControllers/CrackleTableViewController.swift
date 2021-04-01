//
//  CrackleTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import UIKit

class CrackleTableViewController: UITableViewController {

    let interactor: Interactor
    var clay = ""
    var temperature = ""
    var crackle = ["Много цека", "Мало цека", "Нет цека"]

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
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "cracklesTableView"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return crackle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.accessibilityIdentifier = "crackleCell"

        cell.textLabel?.text = crackle[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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

        let glazesViewController = GlazesTableViewController(interactor: interactor)
        glazesViewController.clay = clay
        glazesViewController.temperature = temperature
        glazesViewController.crackleId = crackleId
        self.navigationController?.show(glazesViewController, sender: self)

    }





}
