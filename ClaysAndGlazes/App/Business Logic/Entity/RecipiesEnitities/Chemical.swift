//
//  Chemical.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 13.10.2021.
//


struct Chemical: Codable {

    var name: String
    var content: [String: Float]
    var formula: [String: Float]

}
