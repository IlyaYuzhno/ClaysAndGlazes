//
//  GlazeForClaysTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 14.04.2021.
//

import UIKit

class GlazeForClaysTableViewController: UITableViewController {

    let interactor: Interactor
    var glaze = ""
    var temperature = ""
    var crackleId = ""
    var clays: [String] = []

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
        setupTableView()

        // Get clays list for chosen glaze
        interactor.getClaysForGlaze(for: glaze, temperature: temperature, crackleId: crackleId) { [weak self] clays in
            self?.clays = clays
            self?.tableView.reloadData()
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glazeForClayCell", for: indexPath) as! DefaultCell
        cell.accessibilityIdentifier = "glazeForClayCell"
        cell.configure(item: clays[indexPath.row])
        return cell
    }


    // MARK: - Private
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "\(glaze)"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "glazeForClayTableView"
        clearsSelectionOnViewWillAppear = true
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "glazeForClayCell")
    }

    private func crackle(id: String) -> String {
      var crackle = ""
        switch id {
        case "mnogo":
            crackle = "даёт много"
        case "malo":
            crackle =  "даёт мало"
        case "no":
            crackle =  "не даёт"
        default:
            break
        }
        return crackle
    }

    // MARK: - Section header setup
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "glazeForClaysViewHeader") as? DefaultHeader ?? DefaultHeader(reuseIdentifier: "glazeForClaysViewHeader")
        let x = crackle(id: crackleId)
        header.titleLabel.text = "\(glaze) на \(temperature) \(x) цека для:"
        return header
    }


}
