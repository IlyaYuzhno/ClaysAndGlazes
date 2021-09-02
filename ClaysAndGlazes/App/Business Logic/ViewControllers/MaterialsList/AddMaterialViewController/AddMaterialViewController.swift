//
//  AddMaterialViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import UIKit
import iOSDropDown

class AddMaterialViewController: UIViewController {

    let pickerItems = ["Массы", "Глазури", "Инструменты", "Пигменты", "Оксиды", "Краски", "Химия", "Разное"]
    let unitsDropDownListOptions = ["кг", "л", "шт"]
    private var unit = ""

   var viewModel: AddMaterialViewControllerViewModelType?

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ДОБАВИТЬ МАТЕРИАЛ"
        viewModel = AddMaterialViewControllerViewModel()
        setupViews()
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
    }

    // MARK: - Views
    private lazy var itemPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .systemBackground
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
        return textField
    }()

    var unitsDropDownList: DropDown = {
        let dropDown = DropDown()
        dropDown.backgroundColor = .systemBackground
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.layer.cornerRadius = 10
        dropDown.layer.borderWidth = 2
        dropDown.layer.borderColor = UIColor.systemGray2.cgColor
        dropDown.selectedRowColor = .BackgroundColor2
        dropDown.contentMode = .center
        dropDown.textAlignment = .center
        dropDown.inputView = UIView()
        return dropDown
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
        textField.tag = 0
        textField.addTarget(self, action: #selector(scrollViews), for: .touchDown)
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
        view.addSubviews(itemPicker, itemNameTextField, itemQuantityTextField, unitsDropDownList, itemInfoTextField, addButton)
        itemInfoTextField.delegate = self
        unitsDropDownList.optionArray = unitsDropDownListOptions
        selectUnit()
        setPicker()
        setupConstraints()
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            itemPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            itemPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemPicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            itemPicker.heightAnchor.constraint(equalToConstant: 100),

            itemNameTextField.topAnchor.constraint(equalTo: itemPicker.bottomAnchor, constant: 40),
            itemNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -5),
            itemNameTextField.heightAnchor.constraint(equalToConstant: 50),

            itemQuantityTextField.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 40),
            itemQuantityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            itemQuantityTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            itemQuantityTextField.heightAnchor.constraint(equalToConstant: 50),

            unitsDropDownList.topAnchor.constraint(equalTo: itemQuantityTextField.topAnchor),
            unitsDropDownList.leadingAnchor.constraint(equalTo: itemQuantityTextField.trailingAnchor, constant: 10),
            unitsDropDownList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            unitsDropDownList.heightAnchor.constraint(equalTo: itemQuantityTextField.heightAnchor),


            itemInfoTextField.topAnchor.constraint(equalTo: itemQuantityTextField.bottomAnchor, constant: 40),
            itemInfoTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemInfoTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -5),
            itemInfoTextField.heightAnchor.constraint(equalToConstant: 50),

            addButton.topAnchor.constraint(equalTo: itemInfoTextField.bottomAnchor, constant: 15),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 70),
        ])
    }

    // MARK: - Add Button Pressed
    @objc func addButtonPressed(sender: UIButton) {
        guard let viewModel = viewModel else { return }

        // Get item parameters
        let itemType = pickerItems[itemPicker.selectedRow(inComponent: 0)]
        let itemName = itemNameTextField.text ?? ""
        let itemQuantity = itemQuantityTextField.text ?? ""
        let itemInfo = itemInfoTextField.text ?? ""

        // Add new material to storage
        viewModel.addNewMaterial(type: itemType, quantity: itemQuantity, unit: unit, name: itemName, info: itemInfo)

        // Get back to Materials List VC
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Tap on InfoTextField and move all views up for keyboard
    @objc func scrollViews(textField: UITextField) {
        // Height iphone 8, SE - 667, 11 - 896, 12 - 844
        if UIScreen.main.bounds.height <= 700 && itemInfoTextField.tag == 0 {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y -= 80
            }
            itemInfoTextField.tag = 1
        }
    }

    // MARK: - Hide the keyboard and return view in initial position
    @objc func keyboardWillHide(notification: NSNotification) {
        if UIScreen.main.bounds.height <= 700 {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y += 80
            }
            itemInfoTextField.tag = 0
        }
    }

    func selectUnit() {
        unitsDropDownList.didSelect { [weak self] (selectedText, _, _) in
            self?.unit = selectedText
        }
    }

    deinit {
        unsubscribeFromAllNotifications()
    }
}
