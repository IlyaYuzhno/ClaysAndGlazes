//
//  Materials.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//


struct Material: Codable, Hashable {
    var type: String
    var name: String
    var quantity: String
    var info: String
    var marked: Bool
}
