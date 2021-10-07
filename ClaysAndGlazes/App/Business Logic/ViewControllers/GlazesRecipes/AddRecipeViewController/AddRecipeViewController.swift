//
//  AddRecipeViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.10.2021.
//

import UIKit

class AddRecipeViewController: UIViewController {

    var viewModel: AddRecipeViewControllerViewModelType?
    var materialsTableViewHeight = 93.0
    private var materialsTableViewHeightConstraint: NSLayoutConstraint!

    let segerFormulaView = SegerFormulaView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let addMaterialsToRecipeView = AddMaterialsToRecipeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddRecipeViewControllerViewModel()
        setBackgroundImage()
        setupView()
        hideKeyboardWhenTappedAroundOnView()
    }

    private func setupView() {
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "ДОБАВЛЯЕМ РЕЦЕПТ"
        addMaterialsToRecipeView.addMaterialsTableView.delegate = self
        addMaterialsToRecipeView.addMaterialsTableView.dataSource = self
        addMaterialsToRecipeView.addMaterialsTableView.register(AddMaterialToRecipeCell.self, forCellReuseIdentifier: "addMaterialToRecipeCell")

        view.addSubviews(segerFormulaView, addMaterialsToRecipeView)

        segerFormulaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segerFormulaView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segerFormulaView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segerFormulaView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        addMaterialsToRecipeView.topAnchor.constraint(equalTo: segerFormulaView.bottomAnchor).isActive = true
        addMaterialsToRecipeView.leadingAnchor.constraint(equalTo: segerFormulaView.leadingAnchor).isActive = true
        addMaterialsToRecipeView.trailingAnchor.constraint(equalTo: segerFormulaView.trailingAnchor).isActive = true

        materialsTableViewHeightConstraint = addMaterialsToRecipeView.heightAnchor.constraint(equalToConstant: materialsTableViewHeight)
        materialsTableViewHeightConstraint.isActive = true
    }
}

// MARK: - Materials Tableview delegate and datasource
extension AddRecipeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMaterialToRecipeCell", for: indexPath) as? AddMaterialToRecipeCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)

        tableViewCell.delegate = self
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }
}

// MARK: - Add new row to materials tableview
extension AddRecipeViewController: AddMaterialToRecipeCellDelegate {

    func addRow() {
        guard let viewModel = viewModel else { return }

        // Add new data to datasource
        viewModel.addData("test 2")

        // Add new row to tableview
        addMaterialsToRecipeView.addMaterialsTableView.beginUpdates()
        addMaterialsToRecipeView.addMaterialsTableView.insertRows(at: [IndexPath.init(row: viewModel.numberOfRowsInSection() - 1, section: 0)], with: .automatic)
        addMaterialsToRecipeView.addMaterialsTableView.endUpdates()

        // Increase view height
        addMaterialsToRecipeView.layoutIfNeeded()
        materialsTableViewHeight += 44
        materialsTableViewHeightConstraint.constant = materialsTableViewHeight
    }


}


