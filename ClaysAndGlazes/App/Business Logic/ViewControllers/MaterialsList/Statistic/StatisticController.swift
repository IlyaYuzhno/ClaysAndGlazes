//
//  StatisticController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

import Foundation

protocol StatisticControllerType: AnyObject {
    func saveToStatistic(itemToSave: MaterialStatisticItem)

}

class StatisticController: StatisticControllerType {
    var items: [MaterialStatisticItem] = []

    func saveToStatistic(itemToSave: MaterialStatisticItem) {

        let itemToEdit = LocalStorageService.retrieveStatisticItem(item: itemToSave)

        let newQuantity = itemToEdit.quantity + itemToSave.quantity

        let newItem = MaterialStatisticItem(name: itemToSave.name, quantity: newQuantity, unit: itemToSave.unit)

        LocalStorageService.saveToStatistic(object: newItem)
        
    }





}
