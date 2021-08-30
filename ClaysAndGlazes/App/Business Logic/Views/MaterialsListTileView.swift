//
//  MaterialsListTileView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.08.2021.
//

import UIKit

class MaterialsListTileView: UIButton {

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
        backgroundColor = .white
        alpha = 0.8
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel?.textAlignment = .center
        setTitleColor(.black, for: .normal)
        titleLabel?.numberOfLines = 0
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

}
