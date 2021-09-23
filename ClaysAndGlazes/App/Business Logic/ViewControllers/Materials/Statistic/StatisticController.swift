//
//  StatisticController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

import Foundation

class StatisticController: StatisticControllerType {

    var statisticList: [MaterialStatisticItem] = []

    func saveToStatistic(itemToSave: MaterialStatisticItem) {
        let itemToEdit = MaterialsLocalStorageService.retrieveStatisticItem(item: itemToSave)

        MaterialsLocalStorageService.removeStatisticItem(itemToRemove: itemToEdit)

        let newQuantity = itemToEdit.quantity + itemToSave.quantity

        let newItem = MaterialStatisticItem(name: itemToSave.name, quantity: newQuantity, unit: itemToSave.unit)

        MaterialsLocalStorageService.saveToStatistic(object: newItem)
    }

    func loadStatisticData(completion: (@escaping () -> ()?)) {
        MaterialsLocalStorageService.retrieveMaterialStatisticList { [weak self] list in
            guard let list = list else { return }
            self?.statisticList = list
            self?.statisticList = self?.getStatisticTopFiveList() ?? []
            completion()
        }
    }

    private func getStatisticTopFiveList() -> [MaterialStatisticItem] {
        statisticList = statisticList.sorted(by: { $0.quantity > $1.quantity })
        
        var topList: [MaterialStatisticItem] = []

        if statisticList.count > 0 {
            (0..<statisticList.count).forEach { i in
                let item = statisticList[i]
                if item.name != "" && i < 5 {
                    topList.append(item)
                } else { return }
            }
        }
        return topList
    }
}
