//
//  TestViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 08.10.2021.
//

import UIKit

class TestViewController: UIViewController {

    var viewModel: AddRecipeViewControllerViewModelType?
    private var materialsTableViewHeight = 93.0
    private var materialsTableViewHeightConstraint: NSLayoutConstraint!

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
        viewModel = AddRecipeViewControllerViewModel()
        setupView()
        hideKeyboardWhenTappedAroundOnView()
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
extension TestViewController: UITableViewDelegate, UITableViewDataSource {

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
extension TestViewController: AddMaterialToRecipeCellDelegate {

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
