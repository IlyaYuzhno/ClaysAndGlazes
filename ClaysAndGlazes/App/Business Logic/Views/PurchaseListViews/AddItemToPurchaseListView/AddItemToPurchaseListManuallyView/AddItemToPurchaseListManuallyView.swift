//
//  AddItemToPurchaseListManuallyView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 09.09.2021.
//

import UIKit
import iOSDropDown

protocol AddItemToPurchaseListManuallyViewDelegate: AnyObject {
    func okButtonTapped()
    func cancelButtonTapped()
}

class AddItemToPurchaseListManuallyView: SupportingView {

    var viewModel: AddItemToPurchaseListManuallyViewViewModelType?
    weak var delegate: AddItemToPurchaseListManuallyViewDelegate?

    private lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Добавить из остатков", "Добавить новый"])
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(segmentedControlTapped), for: .valueChanged)
        return view
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Ок", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()

    let dropDownList: DropDown = {
        let dropDown = DropDown()
        dropDown.backgroundColor = .systemBackground
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.layer.cornerRadius = 10
        dropDown.layer.borderWidth = 2
        dropDown.layer.borderColor = UIColor.systemGray2.cgColor
        dropDown.selectedRowColor = .BackgroundColor2
        dropDown.contentMode = .center
        dropDown.textAlignment = .center
        dropDown.handleKeyboard = false
        dropDown.isSearchEnable = false
        dropDown.inputView = UIView()
        return dropDown
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.returnKeyType = .done

        return textField
    }()

    override init(frame: CGRect, text: String) {
        super.init(frame: frame, text: text)
        viewModel = AddItemToPurchaseListManuallyViewViewModel()
        viewModel?.loadData()
        setupView()
        dropDownListSelectedItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        text = "Добавьте материал в список покупок вручную или из списка остатков:"
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(segmentedControl, textLabel, okButton, cancelButton)

        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true

        segmentedControl.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true

        okButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        okButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        okButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true

        cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: okButton.trailingAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: okButton.heightAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    }

    @objc func segmentedControlTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showDropDown()
        case 1:
            showTextField()
        default:
            break
        }
    }

    private func showTextField() {

        dropDownList.removeFromSuperview()
        addSubview(textField)

        textField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        textField.delegate = self
    }

    private func showDropDown() {

        textField.removeFromSuperview()
        addSubview(dropDownList)

        dropDownList.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40).isActive = true
        dropDownList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        dropDownList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dropDownList.heightAnchor.constraint(equalToConstant: 50).isActive = true

        dropDownList.optionArray = viewModel?.dropDownItemsArray ?? [""]
    }

    func dropDownListSelectedItem() {
        dropDownList.didSelect { [weak self] (selectedText, _, _) in
            self?.viewModel?.selectedText = selectedText
        }
    }

    @objc func okButtonTapped() {
        if let text = textField.text, !text.isEmpty {
            viewModel?.selectedText = text
            delegate?.okButtonTapped()
        } else if let text = textField.text, text.isEmpty && segmentedControl.selectedSegmentIndex == 1 {
            Animation.circularBorderAnimate(sender: textField)
        } else if segmentedControl.selectedSegmentIndex == 0 {
            delegate?.okButtonTapped()
        }
    }

    @objc func cancelButtonTapped() {
        delegate?.cancelButtonTapped()
    }

}

extension AddItemToPurchaseListManuallyView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
