//
//  StatisticTableViewCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.09.2021.
//

import Foundation

class StatisticTableViewCellViewModel: StatisticTableViewCellViewModelType {

    private var item: MaterialStatisticItem
    private var indexPath: IndexPath

    var title: String {
        return "\(indexPath.row + 1)." + " " + item.name
    }

    var quantity: String {
        return "\(item.quantity)"
    }

    var unit: String {
        return item.unit
    }

    init(item: MaterialStatisticItem, indexPath: IndexPath) {
        self.item = item
        self.indexPath = indexPath
    }

}

