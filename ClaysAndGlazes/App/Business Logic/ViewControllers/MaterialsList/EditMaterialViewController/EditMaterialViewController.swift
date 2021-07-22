//
//  EditMaterialViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.07.2021.
//

import UIKit

class EditMaterialViewController: UIViewController {

    var name: String = ""
    var info: String = ""
    var quantity: String = ""
    var type: String = ""

    // MARK: - Init
    init(name: String, info: String, quantity: String, type: String) {
        super.init(nibName: nil, bundle: nil)

        self.type = type
        self.info = info
        self.name = name
        self.quantity = quantity
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        hideKeyboardWhenTappedAroundOnView()
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
        textField.backgroundColor = .white
        textField.text = name
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
        textField.backgroundColor = .white
        textField.text = quantity
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
        textField.backgroundColor = .white
        textField.returnKeyType = .done
        textField.text = info
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
        view.addSubviews(itemNameTextField, itemQuantityTextField, itemInfoTextField, editButton)
        itemInfoTextField.delegate = self
        setupConstraints()
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            itemNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
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

        // Get item parameters
        let itemName = itemNameTextField.text ?? ""
        let itemQuantity = itemQuantityTextField.text ?? ""
        let itemInfo = itemInfoTextField.text ?? ""

        // Create new material
        let material = Material.init(type: type, name: itemName, quantity: itemQuantity, info: itemInfo)

        // Save new material to UserDefaults
         LocalStorageService.save(object: material)

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

