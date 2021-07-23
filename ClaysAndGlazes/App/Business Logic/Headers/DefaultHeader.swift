//
//  DefaultHeader.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 07.04.2021.
//

import UIKit

class DefaultHeader: UITableViewHeaderFooterView {

    let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .SectionColor
        let marginGuide = contentView.layoutMarginsGuide

        // Title label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let views = [
            "titleLabel" : titleLabel
        ]
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[titleLabel]-|",
            options: [],
            metrics: nil,
            views: views
        ))
    }

}
