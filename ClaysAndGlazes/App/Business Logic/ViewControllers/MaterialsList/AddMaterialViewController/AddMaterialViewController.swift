//
//  AddMaterialViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import UIKit

class AddMaterialViewController: UIViewController {

    let pickerItems = ["Массы", "Глазури", "Инструменты", "Пигменты", "Оксиды", "Краски", "Химия", "Разное"]

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ДОБАВИТЬ МАТЕРИАЛ"
        setupViews()
        hideKeyboardWhenTappedAroundOnView()
    }

    // MARK: - Views
    private lazy var itemPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

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
        return textField
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить", for: .normal)
        button.backgroundColor = .BackgroundColor2
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    // MARK: - UIPicker setup
    func setPicker() {
        self.itemPicker.delegate = self
        self.itemPicker.dataSource = self
    }

    func setupViews() {
        view.backgroundColor = .BackgroundColor1
        view.addSubviews(itemPicker, itemNameTextField, itemQuantityTextField, itemInfoTextField, addButton)
        itemInfoTextField.delegate = self
        setPicker()
        setupConstraints()
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            itemPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            itemPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemPicker.widthAnchor.constraint(equalTo: view.widthAnchor),

            itemNameTextField.topAnchor.constraint(equalTo: itemPicker.bottomAnchor, constant: 40),
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

            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 70),
        ])
    }

    // MARK: - Add Button Pressed
    @objc func addButtonPressed(sender: UIButton) {

        // Get item parameters
        let itemType = pickerItems[itemPicker.selectedRow(inComponent: 0)]
        let itemName = itemNameTextField.text ?? ""
        let itemQuantity = itemQuantityTextField.text ?? ""
        let itemInfo = itemInfoTextField.text ?? ""

        // Create material
        let material = Material.init(type: itemType, name: itemName, quantity: itemQuantity, info: itemInfo)

        // Save material to UserDefaults
        LocalStorageService.save(object: material)

        // Get back to MaterialsList VC
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIPickerView datasource
extension AddMaterialViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerItems.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerItems[row]
    }

}

// UITextField delegate
extension AddMaterialViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
