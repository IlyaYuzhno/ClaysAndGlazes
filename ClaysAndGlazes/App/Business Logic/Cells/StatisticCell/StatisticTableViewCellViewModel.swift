//
//  StatisticTableViewCellViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.09.2021.
//

import Foundation

class StatisticTableViewCellViewModel: StatisticTableViewCellViewModelType {

    private var item: MaterialStatisticItem

    var title: String {
        return item.name
    }

    var quantity: String {
        return "\(item.quantity)"
    }

    var unit: String {
        return item.unit
    }

    init(item: MaterialStatisticItem) {
        self.item = item
    }

}

