//
//  AddRecipeViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.10.2021.
//

import UIKit

class AddRecipeViewController: UIViewController {

    var viewModel: AddRecipeViewControllerViewModelType?
    var segerFormulaCalculator: SegerFormulaCalculatorType?
    private var materialsTableViewHeight = 93.0
    private var materialsTableViewHeightConstraint: NSLayoutConstraint!
    private var rowHeight = 44.0
    private var totalValue: Float = 0.0 {
        didSet {
            bottomView.totalValueLabel.text = String(totalValue)
        }
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let contentWidth = UIScreen.main.bounds.size.width
        let contentHeight = UIScreen.main.bounds.size.height * 3
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        return scrollView
    }()

    let segerFormulaView = SegerFormulaView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let addMaterialsToRecipeView = AddMaterialsToRecipeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let bottomView = AddMaterialToRecipeBottomView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        segerFormulaCalculator = SegerFormulaCalculator()
        viewModel = AddRecipeViewControllerViewModel(segerFormulaCalculator: segerFormulaCalculator!)
        viewModel?.delegate = self
        setupView()
        hideKeyboardWhenTappedAroundOnView()
        bottomView.delegate = self
    }

    private func setupView() {
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "ДОБАВЛЯЕМ РЕЦЕПТ"
        view.backgroundColor = .systemBackground
        addMaterialsToRecipeView.addMaterialsTableView.delegate = self
        addMaterialsToRecipeView.addMaterialsTableView.dataSource = self
        addMaterialsToRecipeView.addMaterialsTableView.register(AddMaterialToRecipeCell.self, forCellReuseIdentifier: "addMaterialToRecipeCell")

        scrollView.addSubview(addMaterialsToRecipeView)
        scrollView.addSubview(bottomView)

        view.addSubviews(segerFormulaView, scrollView)

        segerFormulaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segerFormulaView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segerFormulaView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segerFormulaView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        scrollView.topAnchor.constraint(equalTo: segerFormulaView.bottomAnchor, constant: 5).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        addMaterialsToRecipeView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        addMaterialsToRecipeView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        addMaterialsToRecipeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        materialsTableViewHeightConstraint = addMaterialsToRecipeView.heightAnchor.constraint(equalToConstant: materialsTableViewHeight)
        materialsTableViewHeightConstraint.isActive = true

        bottomView.topAnchor.constraint(equalTo: addMaterialsToRecipeView.bottomAnchor, constant: 20).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 150).isActive = true
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

    // MARK: - Delete the material item and table row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete && indexPath.row != 0 {
            guard let viewModel = viewModel else { return }

            // Delete item from datasource
            viewModel.deleteItem(forIndexPath: indexPath)

            // Delete row
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()

            // Decrease view height
            materialsTableViewHeight -= rowHeight
            materialsTableViewHeightConstraint.constant = materialsTableViewHeight
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut) {
                self.addMaterialsToRecipeView.layoutIfNeeded()
            }
        }
    }

    // Make first cell uneditable
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        if indexPath.row == 0 {
            return .none
        } else {
            return .delete
        }
    }

}

// MARK: - Add new row to materials tableview
extension AddRecipeViewController: AddMaterialToRecipeCellDelegate {
    
    func minusValue() {
        if totalValue <= 0.0 {
            totalValue = 0.0
        } else if totalValue > 0.0 {
            totalValue -= 1.0
        }
    }

    func plusValue() {
        totalValue += 1.0
    }

    func addRow() {
        guard let viewModel = viewModel else { return }

        // Add new empty item to datasource
        viewModel.addEmptyItemRow()

        // Add new row to tableview
        addMaterialsToRecipeView.addMaterialsTableView.beginUpdates()
        addMaterialsToRecipeView.addMaterialsTableView.insertRows(at: [IndexPath.init(row: viewModel.numberOfRowsInSection() - 1, section: 0)], with: .automatic)
        addMaterialsToRecipeView.addMaterialsTableView.endUpdates()

        // Increase view height
        materialsTableViewHeight += rowHeight
        materialsTableViewHeightConstraint.constant = materialsTableViewHeight
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseIn) {
            self.addMaterialsToRecipeView.layoutIfNeeded()
        }
    }

    func showChemicalsList() {
        let chemicalsListViewController = RecipeMaterialsListViewController()
        chemicalsListViewController.delegate = self
        navigationController?.pushViewController(chemicalsListViewController, animated: true)
    }

    func passStepperControlValue(value: Float) {
        let currentValue = value
        totalValue += currentValue
    }
}

// MARK: - Reload TableView after new chemical is added
extension AddRecipeViewController: AddRecipeViewControllerViewModelDelegate {
    func reloadTableView() {
        addMaterialsToRecipeView.addMaterialsTableView.reloadData()
    }
}

// MARK: - Add new chemical to chemicals list and calculate formula
extension AddRecipeViewController: RecipeMaterialsListViewControllerDelegate {
    func passData(item: Chemical, selectedIndexPath: IndexPath) {
        viewModel?.addNewItem(item: item)

        // Show formula
        let formula = segerFormulaCalculator?.showFormula()

//        let label: UILabel = {
//            let label = UILabel()
//            label.textColor = .label
//            label.textAlignment = .left
//            label.font = UIFont.systemFont(ofSize: 11, weight: .light)
//            return label
//        }()
//        segerFormulaView.alcaliStack.addArrangedSubview(label)
//        label.text = "SiO2: " + String(formula?["SiO2"] ?? 0)
//        segerFormulaView.layoutIfNeeded()
    }
}

// MARK: - Save, Clear, 100% buttons delegate
extension AddRecipeViewController: AddMaterialToRecipeBottomViewDelegate {
    func percentageButtonTapped() {
        totalValue = 100.0
    }

    func saveRecipeButtonTapped() {

    }

    func clearRecipeButtonTapped() {

        // Clear items list
        viewModel?.clearItemsList()

        totalValue = 0.0

        // Return tableview height to initial value
        materialsTableViewHeight = 93.0
        materialsTableViewHeightConstraint.constant = materialsTableViewHeight
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut) {
            self.addMaterialsToRecipeView.layoutIfNeeded()
        }

    }
}

