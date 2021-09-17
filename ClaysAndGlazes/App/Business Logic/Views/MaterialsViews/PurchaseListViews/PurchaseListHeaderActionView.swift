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
    let cornerRadius: CGFloat = 8

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

    private lazy var squareViewForSelectAll: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = .clear
        return view
    }()

    private lazy var squareViewForTrash: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = .clear
        return view
    }()

    private lazy var blurForTrashView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()

    private lazy var blurForSelectAll: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        squareViewForSelectAll.addSubviews(selectAllButton, blurForSelectAll)
        blurForSelectAll.contentView.addSubview(selectAllButton)

        squareViewForTrash.addSubviews(deleteSelectedItemsButton, blurForTrashView)
        blurForTrashView.contentView.addSubview(deleteSelectedItemsButton)

        addSubviews(squareViewForTrash, squareViewForSelectAll)

        selectAllButton.centerXAnchor.constraint(equalTo: squareViewForSelectAll.centerXAnchor).isActive = true
        selectAllButton.centerYAnchor.constraint(equalTo: squareViewForSelectAll.centerYAnchor).isActive = true
        selectAllButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        selectAllButton.heightAnchor.constraint(equalTo: selectAllButton.widthAnchor).isActive = true

        squareViewForSelectAll.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        squareViewForSelectAll.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        squareViewForSelectAll.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        squareViewForSelectAll.heightAnchor.constraint(equalTo: squareViewForSelectAll.widthAnchor).isActive = true

        squareViewForTrash.leadingAnchor.constraint(equalTo: squareViewForSelectAll.trailingAnchor, constant: 2).isActive = true
        squareViewForTrash.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        squareViewForTrash.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        squareViewForTrash.heightAnchor.constraint(equalTo: squareViewForSelectAll.heightAnchor).isActive = true

        deleteSelectedItemsButton.trailingAnchor.constraint(equalTo: squareViewForTrash.trailingAnchor, constant: -10).isActive = true
        deleteSelectedItemsButton.centerYAnchor.constraint(equalTo: squareViewForTrash.centerYAnchor).isActive = true
        deleteSelectedItemsButton.widthAnchor.constraint(equalTo: squareViewForTrash.heightAnchor, multiplier: 0.6).isActive = true
        deleteSelectedItemsButton.heightAnchor.constraint(equalTo: deleteSelectedItemsButton.widthAnchor).isActive = true

        blurForTrashView.leadingAnchor.constraint(equalTo: squareViewForTrash.leadingAnchor).isActive = true
        blurForTrashView.topAnchor.constraint(equalTo: squareViewForTrash.topAnchor).isActive = true
        blurForTrashView.bottomAnchor.constraint(equalTo: squareViewForTrash.bottomAnchor).isActive = true
        blurForTrashView.trailingAnchor.constraint(equalTo: squareViewForTrash.trailingAnchor).isActive = true

        blurForSelectAll.leadingAnchor.constraint(equalTo: squareViewForSelectAll.leadingAnchor).isActive = true
        blurForSelectAll.topAnchor.constraint(equalTo: squareViewForSelectAll.topAnchor).isActive = true
        blurForSelectAll.bottomAnchor.constraint(equalTo: squareViewForSelectAll.bottomAnchor).isActive = true
        blurForSelectAll.trailingAnchor.constraint(equalTo: squareViewForSelectAll.trailingAnchor).isActive = true
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
