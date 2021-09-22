//
//  AddMaterialViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import UIKit
import iOSDropDown

class AddMaterialViewController: UIViewController {

    let pickerItems = ["Массы", "Глазури", "Инструменты", "Пигменты", "Оксиды", "Краски", "Глазурная химия", "Разное"]
    let unitsDropDownListOptions = ["кг", "л", "шт", "oz."]
    private var unit = ""
    private var scrollView = UIScrollView()

    var viewModel: AddMaterialViewControllerViewModelType?

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
        textField.returnKeyType = .done
        textField.tag = 100
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
        dropDown.placeholder = "кг..."
        dropDown.handleKeyboard = false
        dropDown.isSearchEnable = false
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

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ДОБАВИТЬ МАТЕРИАЛ"
        viewModel = AddMaterialViewControllerViewModel()
        setupViews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize.height = 2000
        scrollView.contentSize.width = scrollView.frame.size.width
        scrollView.contentMode = .scaleAspectFit
    }

    // MARK: - UIPicker setup
    func setPicker() {
        self.itemPicker.delegate = self
        self.itemPicker.dataSource = self
    }

    func setupViews() {
        view.backgroundColor = .BackgroundColor1
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubviews(itemPicker, itemNameTextField, itemQuantityTextField, unitsDropDownList, itemInfoTextField, addButton)
        view.addSubview(scrollView)
        itemInfoTextField.delegate = self
        itemQuantityTextField.delegate = self
        unitsDropDownList.optionArray = unitsDropDownListOptions
        selectUnit()
        setPicker()
        setupConstraints()
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            itemPicker.topAnchor.constraint(equalTo: scrollView.topAnchor),
            itemPicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            itemPicker.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            itemPicker.heightAnchor.constraint(equalToConstant: 100),

            itemNameTextField.topAnchor.constraint(equalTo: itemPicker.bottomAnchor, constant: 40),
            itemNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            itemNameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            itemNameTextField.heightAnchor.constraint(equalToConstant: 50),

            itemQuantityTextField.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 40),
            itemQuantityTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            itemQuantityTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.75),
            itemQuantityTextField.heightAnchor.constraint(equalToConstant: 50),

            unitsDropDownList.topAnchor.constraint(equalTo: itemQuantityTextField.topAnchor),
            unitsDropDownList.leadingAnchor.constraint(equalTo: itemQuantityTextField.trailingAnchor, constant: 10),
            unitsDropDownList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            unitsDropDownList.heightAnchor.constraint(equalTo: itemQuantityTextField.heightAnchor),

            itemInfoTextField.topAnchor.constraint(equalTo: itemQuantityTextField.bottomAnchor, constant: 40),
            itemInfoTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            itemInfoTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
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
        if itemName != "" && itemQuantity != "" {
            viewModel.addNewMaterial(type: itemType, quantity: itemQuantity, unit: unit, name: itemName, info: itemInfo, viewController: self)

            // Get back to Materials List VC
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            
            Animation.circularBorderAnimate(sender: itemNameTextField)
            Animation.circularBorderAnimate(sender: itemQuantityTextField)
    }

    }

    // MARK: - Tap on InfoTextField and move all views up for keyboard
    @objc func scrollViews(textField: UITextField) {
        // Height iphone 8, SE - 667, 11 - 896, 12 - 844
        if UIScreen.main.bounds.height <= 700 && textField.tag == 0 {
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
