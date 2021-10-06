//
//  RecipesFilterView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.10.2021.
//

import UIKit

protocol RecipesFilterViewDelegate: AnyObject {
    func addFilterButtonTapped()
}

class RecipesFilterView: UIView {

    weak var delegate: RecipesFilterViewDelegate?

    private lazy var addFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .SectionColor
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addFilterButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(addFilterButton)

        addFilterButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addFilterButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addFilterButton.widthAnchor.constraint(equalTo: addFilterButton.heightAnchor).isActive = true
        addFilterButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    @objc func addFilterButtonTapped() {
        delegate?.addFilterButtonTapped()
    }

}
