//
//  StatisticController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

import Foundation

class StatisticController: StatisticControllerType {

    let storageKey = MaterialsLocalStorageKeys.materialsStatisticListKey
    var statisticList: [MaterialStatisticItem] = []

    func saveToStatistic(itemToSave: MaterialStatisticItem) {
        let itemToEdit = MaterialsLocalStorageService.retrieveStatisticItemFromStorage(item: itemToSave)

        MaterialsLocalStorageService.removeItemInStorage(itemToRemove: itemToEdit, key: storageKey)

        let newQuantity = itemToEdit.quantity + itemToSave.quantity

        let newItem = MaterialStatisticItem(name: itemToSave.name, quantity: newQuantity, unit: itemToSave.unit)

        MaterialsLocalStorageService.saveDataToStorage(object: newItem, key: storageKey)
    }

    func loadStatisticData(completion: (@escaping () -> ()?)) {
        MaterialsLocalStorageService.retrieveDataFromStorage(key: MaterialsLocalStorageKeys.materialsStatisticListKey, type: MaterialStatisticItem.self) {
            [weak self] list in
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
