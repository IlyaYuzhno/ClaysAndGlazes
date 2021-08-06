//
//  InformationViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.08.2021.
//

import UIKit

class InformationViewViewModel: InformationViewViewModelType {
    var itemName: String
    var itemInfo: String
    var mode: String


    init(itemName: String, itemInfo: String, mode: String) {
        self.itemInfo = itemInfo
        self.itemName = itemName
        self.mode = mode
    }

}

