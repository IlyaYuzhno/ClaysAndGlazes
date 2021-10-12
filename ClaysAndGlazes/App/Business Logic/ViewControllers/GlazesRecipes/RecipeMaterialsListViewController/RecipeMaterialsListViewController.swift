//
//  RecipeMaterialsListViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 12.10.2021.
//

import UIKit

protocol RecipeMaterialsListViewControllerDelegate: AnyObject {
    func passData(item: String, selectedIndexPath: IndexPath)
}

class RecipeMaterialsListViewController: UIViewController {

    var viewModel: RecipeMaterialsListViewViewModelType?
    weak var delegate: RecipeMaterialsListViewControllerDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выбери материал:"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .left
        return label
    }()

     var chemicalsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RecipeMaterialsListViewViewModel()
        setupView()
        chemicalsTableView.delegate = self
        chemicalsTableView.dataSource = self
        chemicalsTableView.register(ChemicalsListCell.self, forCellReuseIdentifier: "chemicalsListCell")
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, chemicalsTableView)

        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        chemicalsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        chemicalsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chemicalsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chemicalsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }

}

extension RecipeMaterialsListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chemicalsListCell", for: indexPath) as? ChemicalsListCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        viewModel.selectRow(atIndexPath: indexPath)

        let item = viewModel.itemToPass()
        delegate?.passData(item: item, selectedIndexPath: indexPath)

        navigationController?.popViewController(animated: true)
    }

}
