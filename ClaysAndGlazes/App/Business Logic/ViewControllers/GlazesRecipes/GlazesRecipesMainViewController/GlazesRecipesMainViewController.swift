//
//  GlazesRecipesMainViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 05.10.2021.
//

import UIKit

class GlazesRecipesMainViewController: UIViewController {

    var viewModel: GlazesRecipesMainViewViewModelType?
    let actionsView = RecipesMainActionsView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let filterView = RecipesFilterView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    let recipesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GlazesRecipesMainViewViewModel()
        setupView()
    }

    private func setupView() {
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "РЕЦЕПТЫ"
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "recipeCollectionViewCell")
        setBackgroundImage()
        setupConstraints()

        actionsView.delegate = self
    }

    private func setupConstraints() {
        view.addSubviews(actionsView, recipesCollectionView, filterView)

        actionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        actionsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        actionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        actionsView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        recipesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipesCollectionView.bottomAnchor.constraint(equalTo: actionsView.topAnchor).isActive = true
        recipesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true

        filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        filterView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}

extension GlazesRecipesMainViewController: RecipesMainActionsViewDelegate {

    func addRecipe() {
       let addRecipeVC = AddRecipeViewController()
        //let testVC = TestViewController()
       navigationController?.pushViewController(addRecipeVC, animated: true)
    }

    func searchRecipe() {
        print(#function)
    }

    func showFavoritesRecipe() {
        print(#function)
    }


}


extension GlazesRecipesMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCollectionViewCell", for: indexPath) as? RecipeCollectionViewCell
        guard let collectionCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath.item)
        collectionCell.viewModel = cellViewModel
        collectionCell.delegate = self

        return collectionCell
    }
}

extension GlazesRecipesMainViewController: RecipeCollectionViewCellDelegate {

    func likeButtonTapped() {
        print(#function)
    }

    func shareButtonTapped() {
        print(#function)
    }


}
