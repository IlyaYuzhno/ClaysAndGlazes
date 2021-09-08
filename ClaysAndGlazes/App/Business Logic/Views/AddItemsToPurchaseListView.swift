//
//  AddItemsToPurchaseListView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 07.09.2021.
//

import UIKit

protocol AddItemsToPurchaseListViewDelegate: AnyObject {
    func okButtonTapped()
    func cancelButtonTapped()
}

class AddItemsToPurchaseListView: SupportingView {

    weak var delegate: AddItemsToPurchaseListViewDelegate?

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

    override func setupView() {
        text = "Add zero item to purchase list?"
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(textLabel, okButton, cancelButton)

        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        textLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true

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

    @objc func okButtonTapped() {
        delegate?.okButtonTapped()
    }

    @objc func cancelButtonTapped() {
        delegate?.cancelButtonTapped()
    }

}
