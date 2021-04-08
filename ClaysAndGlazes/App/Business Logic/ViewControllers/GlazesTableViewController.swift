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
        tableView.backgroundColor = .BackgroundColor1
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "glazesTableView"
        tableView.register(DefaultCell.self, forCellReuseIdentifier: "glazesCell")

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "glazesCell", for: indexPath) as! DefaultCell
        cell.configure(item: glazes[indexPath.row])
        cell.accessibilityIdentifier = "glazesCell"
        return cell
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "glazesViewHeader") as? DefaultHeader ?? DefaultHeader(reuseIdentifier: "glazesViewHeader")
        header.titleLabel.font = .boldSystemFont(ofSize: 22)
        header.titleLabel.text = "Глазури \(brand[section]):"
        return header
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
