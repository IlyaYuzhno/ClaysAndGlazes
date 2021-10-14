//
//  StepperControl.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 07.10.2021.
//

import UIKit

protocol StepperControlDelegate: AnyObject {
    func passValue(value: Float)
    func minusValue()
    func plusValue()
}

class StepperControl: UIView {

    weak var delegate: StepperControlDelegate?

//    var defaultValue = 0.0 {
//        didSet {
//            delegate?.passValue(value: Float(defaultValue))
//        }
//    }

    var defaultValue = 0.0

    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("\u{2212}", for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()

     lazy var valueLabel: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .label
        textField.textAlignment = .center
        textField.text = String(defaultValue)
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.keyboardType = .decimalPad
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(minusButton, valueLabel, plusButton)

        minusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minusButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: 20).isActive = true

        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor).isActive = true

        plusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }


    @objc func minusButtonTapped() {
        delegate?.minusValue()

//        if defaultValue <= 0.0 {
//            valueLabel.text = String(0.0)
//        } else if defaultValue > 0.0 {
//            defaultValue -= 1.0
//            valueLabel.text = String(defaultValue)
//            delegate?.minusValue()
//        }
    }

    @objc func plusButtonTapped() {
        delegate?.plusValue()

//        if defaultValue < 0.0 {
//            valueLabel.text = String(0.0)
//        } else if defaultValue >= 0.0 {
//            defaultValue += 1.0
//            valueLabel.text = String(defaultValue)
//            delegate?.plusValue()
//        }
    }


}
