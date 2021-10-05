//
//  RecipeCollectionCellViewModel.swift
//
//
//  Created by Ilya Doroshkevitch on 20.09.2021.
//

import Foundation
import UIKit

protocol RecipeCollectionCellViewModelType: AnyObject {
    var title: String { get }
    var description: String { get }
    var image: UIImage { get }
    var isFavorite: Bool { get }
    var isShared: Bool { get }
}

class CustomCollectionCellViewModel: RecipeCollectionCellViewModelType {

    private var item: Recipe

    var title: String {
        return item.title
    }

    var description: String {
        return item.description
    }

    var image: UIImage {
        return item.image
    }

    var isFavorite: Bool {
        return item.isFavorite
    }

    var isShared: Bool {
        return item.isShared
    }

    init(item: Recipe) {
        self.item = item
    }
}
