//
//  GlazesRecipesMainViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 05.10.2021.
//

import Foundation
import UIKit

protocol GlazesRecipesMainViewViewModelType: AnyObject {
    func numberOfItemsInSection() -> Int
    func didSelectItemAt(indexPath: IndexPath)
    func cellViewModel(forIndexPath indexPath: Int) -> RecipeCollectionCellViewModelType?
}

class GlazesRecipesMainViewViewModel: GlazesRecipesMainViewViewModelType {

    var recipes: [Recipe] = [
        Recipe(title: "title 1", image: UIImage(named: "placeholder")!, description: "Description 1", isFavorite: false, isShared: false),
        Recipe(title: "title 2", image: UIImage(named: "placeholder")!, description: "Description 2", isFavorite: false, isShared: false),
        Recipe(title: "title 3", image: UIImage(named: "placeholder")!, description: "Description 3", isFavorite: false, isShared: false),]

    func loadData() {

        
    }

    func numberOfItemsInSection() -> Int {
        return recipes.count
    }

    func didSelectItemAt(indexPath: IndexPath) {

    }

    func cellViewModel(forIndexPath indexPath: Int) -> RecipeCollectionCellViewModelType? {

        let item = recipes[indexPath]

        return CustomCollectionCellViewModel(item: item)

    }


    
}
