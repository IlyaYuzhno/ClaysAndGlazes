//
//  RecipesMainActionsView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 05.10.2021.
//

import UIKit

protocol RecipesMainActionsViewDelegate: AnyObject {
    func addRecipe()
    func searchRecipe()
    func showFavoritesRecipe()
}

class RecipesMainActionsView: UIView {

    weak var delegate:RecipesMainActionsViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var addRecipeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .SectionColor
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var searchRecipeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .SectionColor
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchRecipeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var favoriteRecipeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .SectionColor
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteRecipeButtonTapped), for: .touchUpInside)
        return button
    }()

    private var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 50
        stack.layoutMargins = UIEdgeInsets(top: 15, left: 70, bottom: 10, right: 70)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.isUserInteractionEnabled = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

   func setupView() {
        backgroundColor = .systemBackground
       alpha = 0.9
        translatesAutoresizingMaskIntoConstraints = false
       stack.addArrangedSubview(addRecipeButton)
       stack.addArrangedSubview(searchRecipeButton)
       stack.addArrangedSubview(favoriteRecipeButton)
       addSubview(stack)


       stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
       stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
       stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       stack.topAnchor.constraint(equalTo: topAnchor).isActive = true

       

//       addRecipeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//       addRecipeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//       addRecipeButton.widthAnchor.constraint(equalTo: addRecipeButton.heightAnchor).isActive = true
//       addRecipeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
//
//       searchRecipeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//       searchRecipeButton.leadingAnchor.constraint(equalTo: addRecipeButton.trailingAnchor, constant: 20).isActive = true
//       searchRecipeButton.widthAnchor.constraint(equalTo: addRecipeButton.heightAnchor).isActive = true
//       searchRecipeButton.heightAnchor.constraint(equalTo: addRecipeButton.heightAnchor).isActive = true
//
//       favoriteRecipeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//       favoriteRecipeButton.leadingAnchor.constraint(equalTo: searchRecipeButton.trailingAnchor, constant: 20).isActive = true
//       favoriteRecipeButton.heightAnchor.constraint(equalTo: addRecipeButton.heightAnchor).isActive = true
//       favoriteRecipeButton.widthAnchor.constraint(equalTo: addRecipeButton.heightAnchor).isActive = true
    }

    @objc func addButtonTapped() {
        delegate?.addRecipe()
    }

    @objc func searchRecipeButtonTapped() {
        delegate?.searchRecipe()
    }

    @objc func favoriteRecipeButtonTapped() {
        delegate?.showFavoritesRecipe()
    }
}
