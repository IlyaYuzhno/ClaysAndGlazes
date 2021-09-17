//
//  MaterialsListMainViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

import Foundation


protocol MaterialsListMainViewViewModelType: AnyObject {
    var statisticList: [MaterialStatisticItem] { get }
    
    func loadStatisticData(completion: @escaping ([MaterialStatisticItem])-> Void)
}


class MaterialsListMainViewViewModel: MaterialsListMainViewViewModelType {

    var statisticList = [
        MaterialStatisticItem(name: "", quantity: 0, unit: ""),
        MaterialStatisticItem(name: "", quantity: 0, unit: ""),
        MaterialStatisticItem(name: "", quantity: 0, unit: ""),
        MaterialStatisticItem(name: "", quantity: 0, unit: ""),
        MaterialStatisticItem(name: "", quantity: 0, unit: "")
    ]

    func loadStatisticData(completion: @escaping ([MaterialStatisticItem])-> Void) {
        LocalStorageService.retrieveMaterialStatisticList { [weak self] list in
            guard let list = list else { return }

            (0..<list.count).forEach { i in
                let item = list[i]
                self?.statisticList[i] = item
            }

            let topFive = self?.getStatisticTopFiveList()
            completion(topFive ?? [])
        }
    }

    private func getStatisticTopFiveList() -> [MaterialStatisticItem] {
        statisticList = statisticList.sorted(by: { $0.quantity > $1.quantity })

        var topList = [
            MaterialStatisticItem(name: "", quantity: 0, unit: ""),
            MaterialStatisticItem(name: "", quantity: 0, unit: ""),
            MaterialStatisticItem(name: "", quantity: 0, unit: ""),
            MaterialStatisticItem(name: "", quantity: 0, unit: ""),
            MaterialStatisticItem(name: "", quantity: 0, unit: "")]

        (0...4).forEach { i in
            let item = statisticList[i]
            topList[i] = item
        }
        return topList
    }



    
}
