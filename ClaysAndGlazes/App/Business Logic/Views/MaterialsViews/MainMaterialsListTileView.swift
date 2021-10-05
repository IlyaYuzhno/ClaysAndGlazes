//
//  MainMaterialsListView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 10.09.2021.
//

import UIKit

final class UILabelPadded: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: -20, left: 0, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}

class MainMaterialsListTileView: UIView {

    var imageTrailingOffset: Int = 0 {
        willSet {
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(newValue)).isActive = true
        }
    }

    var titleLabel: UILabelPadded = {
        let label = UILabelPadded()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(titleLabel, imageView)

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true

        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true

        imageView.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

}
