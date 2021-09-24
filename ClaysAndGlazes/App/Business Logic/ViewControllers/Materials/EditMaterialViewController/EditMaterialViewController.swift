//
//  EditMaterialViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.07.2021.
//

import UIKit

class EditMaterialViewController: UIViewController {

    var viewModel: EditMaterialViewModelType?

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        hideKeyboardWhenTappedAroundOnView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        itemInfoTextField.text = viewModel.info
        itemNameTextField.text = viewModel.name
        itemQuantityTextField.text = String(viewModel.quantity)
    }

    // MARK: - Views
    private lazy var itemNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 24, weight: .light)
        textField.textAlignment = .left
        textField.placeholder = "   Название материала"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.backgroundColor = .systemBackground
        return textField
    }()

    private lazy var itemQuantityTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 24, weight: .light)
        textField.textAlignment = .left
        textField.placeholder = "   Количество материала"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.backgroundColor = .systemBackground
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()

    private lazy var itemInfoTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 24, weight: .light)
        textField.textAlignment = .left
        textField.placeholder = "   Информация о материале"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.backgroundColor = .systemBackground
        textField.returnKeyType = .done
        return textField
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Исправить", for: .normal)
        button.backgroundColor = .BackgroundColor2
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(editButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    // MARK: - SetupViews
    func setupViews() {
        view.backgroundColor = .BackgroundColor1
        guard let viewModel = viewModel else { return }
        title = ("Исправляем \(viewModel.name)")
        view.addSubviews(itemNameTextField, itemQuantityTextField, itemInfoTextField, editButton)
        itemInfoTextField.delegate = self
        setupConstraints()
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            itemNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -5),
            itemNameTextField.heightAnchor.constraint(equalToConstant: 50),

            itemQuantityTextField.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 40),
            itemQuantityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemQuantityTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -5),
            itemQuantityTextField.heightAnchor.constraint(equalToConstant: 50),

            itemInfoTextField.topAnchor.constraint(equalTo: itemQuantityTextField.bottomAnchor, constant: 40),
            itemInfoTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemInfoTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -5),
            itemInfoTextField.heightAnchor.constraint(equalToConstant: 50),

            editButton.bottomAnchor.constraint(equalTo: itemInfoTextField.bottomAnchor, constant: 120),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 70),
        ])
    }

    // MARK: - Edit Button Pressed
    @objc func editButtonPressed(sender: UIButton) {
        guard let viewModel = viewModel else { return }

        // Get new item parameters
        let itemName = itemNameTextField.text ?? ""
        let itemQuantity:Float? = Float(itemQuantityTextField.text ?? "")
        let itemInfo = itemInfoTextField.text ?? ""

        viewModel.editMaterial(itemName: itemName, itemQuantity: itemQuantity ?? 0, itemInfo: itemInfo)

        // Get back to MaterialsList VC
        self.navigationController?.popViewController(animated: true)
    }
}

// UITextField delegate
extension EditMaterialViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

