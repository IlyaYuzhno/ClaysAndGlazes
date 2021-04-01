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
    var brand: [String] = []


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

        getInfo()

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return brand.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glazes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.accessibilityIdentifier = "glazesCell"

        cell.textLabel?.text = glazes[indexPath.row]
        
        return cell
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Глазури \(brand[section]):"
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }


    // MARK: - Private
    private func getInfo() {
        let serialQueue = DispatchQueue(label: "com.queue.Serial")
        serialQueue.sync {
            // Get glazes
            self.interactor.getGlazes(for: self.clay, temperature: self.temperature, crackleId: self.crackleId) { [weak self] items in
                self?.glazes = items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        // Get glazes brand
        self.interactor.getGlazesBrand(for: self.glazes.first ?? "") { [weak self] brand in
            self?.brand = brand
            self?.tableView.reloadData()
        }
    }


}
