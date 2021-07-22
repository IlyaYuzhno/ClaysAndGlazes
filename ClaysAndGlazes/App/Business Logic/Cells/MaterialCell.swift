//
//  MaterialCell.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.07.2021.
//

import UIKit

class MaterialCell: UITableViewCell {

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(nameLabel)
        addSubview(infoLabel)
        addSubview(quantityLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint .activate([

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -50),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),

            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            infoLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            infoLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -50),
            infoLabel.heightAnchor.constraint(equalToConstant: 20),

            quantityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -5),
            quantityLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            quantityLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 24)
        ])
    }

    // MARK: - Configure
    func configure(name: String, info: String, quantity: String) {
        nameLabel.text = name
        infoLabel.text = info
        quantityLabel.text = quantity
    }
}
