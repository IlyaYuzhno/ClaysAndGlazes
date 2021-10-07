//
//  AddMaterialsToRecipeView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.10.2021.
//

import UIKit

class AddMaterialsToRecipeView: UIView {

    private lazy var recipeTitleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        textField.textAlignment = .left
        textField.placeholder = "  Введите название"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.backgroundColor = .systemBackground
        textField.returnKeyType = .done
        return textField
    }()

    var addMaterialsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false

        return tableView
    }()


    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        recipeTitleTextField.delegate = self

        addSubviews(recipeTitleTextField, addMaterialsTableView)

        recipeTitleTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipeTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        recipeTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        recipeTitleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        addMaterialsTableView.topAnchor.constraint(equalTo: recipeTitleTextField.bottomAnchor, constant: 10).isActive = true
        addMaterialsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addMaterialsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        addMaterialsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}



extension AddMaterialsToRecipeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
