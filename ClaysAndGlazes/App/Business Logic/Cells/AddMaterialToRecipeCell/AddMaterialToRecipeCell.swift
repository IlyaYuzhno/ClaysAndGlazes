//
//  AddMaterialToRecipeCell.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 07.10.2021.
//

import UIKit

protocol AddMaterialToRecipeCellDelegate: AnyObject {
    func addRow()
}

class AddMaterialToRecipeCell: UITableViewCell {

    weak var delegate: AddMaterialToRecipeCellDelegate?

    weak var viewModel: AddMaterialToRecipeCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            materialNameLabel.text = viewModel.text
        }
    }

    let stepperControl = StepperControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    lazy var addNewLineButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNewLineButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var materialNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        label.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(materialNameLabelTapped(sender:)))
        label.addGestureRecognizer(tapGestureRecognizer)

        let border = CALayer()
        border.frame = CGRect(x: 0, y: 30, width: 200, height: 1)
        border.backgroundColor = UIColor.black.cgColor;

        label.layer.addSublayer(border)

        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    func setupViews() {
        selectionStyle = .none
        contentView.addSubview(addNewLineButton)
        contentView.addSubview(materialNameLabel)
        contentView.addSubview(stepperControl)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint .activate([

            addNewLineButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addNewLineButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            addNewLineButton.widthAnchor.constraint(equalTo: addNewLineButton.heightAnchor),
            addNewLineButton.heightAnchor.constraint(equalToConstant: 30),

            materialNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            materialNameLabel.leadingAnchor.constraint(equalTo: addNewLineButton.trailingAnchor, constant: 5),
            materialNameLabel.trailingAnchor.constraint(equalTo: stepperControl.leadingAnchor),
            materialNameLabel.heightAnchor.constraint(equalToConstant: 30),

            stepperControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            stepperControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stepperControl.widthAnchor.constraint(equalToConstant: 100),
            stepperControl.heightAnchor.constraint(equalToConstant: 30)
        ])

        addNewLineButton.addTarget(self, action: #selector(addNewLineButtonTapped), for: .touchUpInside)
    }

    @objc func addNewLineButtonTapped() {
        delegate?.addRow()
    }

    @objc func materialNameLabelTapped(sender: UITapGestureRecognizer) {
        delegate?.addRow()
    }
}
