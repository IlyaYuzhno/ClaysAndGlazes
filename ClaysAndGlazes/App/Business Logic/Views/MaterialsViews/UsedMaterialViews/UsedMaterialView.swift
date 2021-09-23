//
//  UsedMaterialView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 31.08.2021.
//

import UIKit
import iOSDropDown

protocol UsedMaterialViewProtocol: AnyObject {
    func showQuantity(for selectedText: String, index: Int)
}

class UsedMaterialView: UIView {

    weak var delegate: UsedMaterialViewProtocol?

    var optionArray: [String] = [] {
        didSet {
            return dropDown.optionArray = optionArray
        }
    }

    var itemUnit: String = "" {
        didSet {
            return materialUnitLabel.text = itemUnit
        }
    }

    var selectedText = ""

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        showSelected()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.backgroundColor = .BackgroundColor1
        dropDown.rowBackgroundColor = .systemBackground
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.layer.borderWidth = 2
        dropDown.layer.borderColor = UIColor.SearchBarColor.cgColor
        dropDown.selectedRowColor = .BackgroundColor2
        dropDown.handleKeyboard = false
        dropDown.isSearchEnable = false
        dropDown.inputView = UIView()
        return dropDown
    }()

    var materialQuantityTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.backgroundColor = .systemBackground
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        return textField
    }()

    private lazy var materialUnitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBackground
        return label
    }()

    func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = .systemBackground
        alpha = 1
        translatesAutoresizingMaskIntoConstraints = false
        materialQuantityTextField.delegate = self
        dropDown.optionArray = optionArray

        addSubview(dropDown)
        addSubview(materialQuantityTextField)
        addSubview(materialUnitLabel)

        dropDown.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        dropDown.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dropDown.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        dropDown.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true

        materialQuantityTextField.leadingAnchor.constraint(equalTo: dropDown.trailingAnchor, constant: 30).isActive = true
        materialQuantityTextField.heightAnchor.constraint(equalTo: dropDown.heightAnchor).isActive = true
        materialQuantityTextField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        materialQuantityTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        materialUnitLabel.leadingAnchor.constraint(equalTo: materialQuantityTextField.trailingAnchor).isActive = true
        materialUnitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        materialUnitLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        materialUnitLabel.heightAnchor.constraint(equalTo: dropDown.heightAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func showSelected() {
        dropDown.didSelect { [weak self] (selectedText, _, _) in
            self?.selectedText = selectedText
            self?.delegate?.showQuantity(for: selectedText, index: self?.dropDown.tag ?? 0)
        }
    }

}


extension UsedMaterialView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // Correcting "," to "." in quantity
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string.contains(",") {
              textField.text = textField.text! + "."
              return false
          }
          return true
  }
}
