//
//  PurchaseListHeaderActionView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 15.09.2021.
//

import UIKit

protocol PurchaseListHeaderActionViewDelegate: AnyObject {
    func selectAll(isSelected: Bool)
    func deleteSelected()
}

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

class PurchaseListHeaderActionView: UIView {

    weak var delegate: PurchaseListHeaderActionViewDelegate?
    var isSelected = false

    private lazy var selectAllButton: RoundButton = {
        let button = RoundButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.setImage(UIImage(named: "uncheckedBox.png"), for: .normal)
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(selectAllButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var deleteSelectedItemsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "trash"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteSelectedItemsButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubviews(selectAllButton, deleteSelectedItemsButton)

        selectAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        selectAllButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectAllButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        selectAllButton.heightAnchor.constraint(equalTo: selectAllButton.widthAnchor).isActive = true

        deleteSelectedItemsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        deleteSelectedItemsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        deleteSelectedItemsButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        deleteSelectedItemsButton.heightAnchor.constraint(equalTo: deleteSelectedItemsButton.widthAnchor).isActive = true
    }

    @objc func selectAllButtonTapped() {
        isSelected = !isSelected
        delegate?.selectAll(isSelected: isSelected)
        if isSelected {
            selectAllButton.setImage(UIImage(named: "checkedBox.png"), for: .normal)
        } else {
            selectAllButton.setImage(UIImage(named: "uncheckedBox.png"), for: .normal)
        }
    }

    @objc func deleteSelectedItemsButtonTapped() {
        delegate?.deleteSelected()
    }
}
