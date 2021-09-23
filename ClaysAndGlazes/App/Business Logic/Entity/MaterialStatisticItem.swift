//
//  MaterialStatisticItem.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

struct MaterialStatisticItem: Codable, Hashable, Equatable {
    var name: String
    var quantity: Float
    var unit: String
}
