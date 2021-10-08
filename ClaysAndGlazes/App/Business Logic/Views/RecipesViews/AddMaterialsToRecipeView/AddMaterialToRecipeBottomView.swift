//
//  AddMaterialToRecipeBottomView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 08.10.2021.
//

import UIKit

protocol AddMaterialToRecipeBottomViewDelegate: AnyObject {
    func percentageButtonTapped()
    func saveRecipeButtonTapped()
    func clearRecipeButtonTapped()
}

class AddMaterialToRecipeBottomView: UIView {

    weak var delegate: AddMaterialToRecipeBottomViewDelegate?

    private lazy var percentageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("100%", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .BackgroundColor2
        button.addTarget(self, action: #selector(percentageButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total:"
        return label
    }()

    private lazy var totalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.label.cgColor
        label.layer.borderWidth = 1
        label.text = "100%"
        label.textAlignment = .center
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .BackgroundColor2
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .BackgroundColor2
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
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

        addSubviews(percentageButton, totalLabel, totalValueLabel, saveButton, clearButton)

        percentageButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        percentageButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        percentageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        percentageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200).isActive = true

        totalLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: percentageButton.trailingAnchor, constant: 20).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        totalLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true

        totalValueLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        totalValueLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor).isActive = true
        totalValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        totalValueLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        totalValueLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true

        saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        clearButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 50).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        clearButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor).isActive = true
        clearButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor).isActive = true
    }

    @objc func percentageButtonTapped() {
        delegate?.percentageButtonTapped()
    }

    @objc func saveButtonTapped() {
        delegate?.saveRecipeButtonTapped()
    }

    @objc func clearButtonTapped() {
        delegate?.clearRecipeButtonTapped()
    }

}
