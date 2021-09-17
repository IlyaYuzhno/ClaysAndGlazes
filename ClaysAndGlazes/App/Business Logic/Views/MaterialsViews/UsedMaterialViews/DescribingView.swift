//
//  DescribingView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 01.09.2021.
//

import UIKit

class DescribingView: UIView {

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var describingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Выберите материал из раскрывающегося списка и введите израсходованное количество"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .SearchBarColor
        label.numberOfLines = 0
        return label
    }()

    private func setupViews() {
        backgroundColor = .SearchBarColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(describingLabel)

        describingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        describingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        describingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        describingLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
