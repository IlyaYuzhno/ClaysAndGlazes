//
//  SupportingView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.09.2021.
//

import UIKit

class SupportingView: UIView {

    var text: String

    // MARK: - Init
    init(frame: CGRect, text: String) {
        self.text = text
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     func setupView() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray5
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(textLabel)

        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        textLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

}
