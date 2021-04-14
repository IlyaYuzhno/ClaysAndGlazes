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
    var glaze = ""
    var temperature = ""
    var mode: String
    var crackle = ["Много цека", "Мало цека", "Нет цека"]

    // MARK: - Init
    init(interactor: Interactor, mode: String) {
        self.interactor = interactor
        self.mode = mode
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
        return crackle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crackleCell", for: indexPath) as! DefaultCell
        cell.configure(item: crackle[indexPath.row])
        cell.accessibilityIdentifier = "crackleCell"
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

        // MARK: Go to next VC
        switch mode {
        case "clay":
            let glazesViewController = GlazesTableViewController(interactor: interactor)
            glazesViewController.clay = clay
            glazesViewController.temperature = temperature
            glazesViewController.crackleId = crackleId
            self.navigationController?.pushViewController(glazesViewController, animated: true)

        case "glaze":
            let glazeForClaysViewController = GlazeForClaysTableViewController(interactor: interactor)
            glazeForClaysViewController.glaze = glaze
            glazeForClaysViewController.temperature = temperature
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
