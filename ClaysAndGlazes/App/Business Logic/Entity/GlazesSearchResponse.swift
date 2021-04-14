//
//  GlazesResponse.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 01.04.2021.
//
import Foundation

struct GlazesSearchResponse: Codable {

    let glazes: [Item]

    struct Item: Codable {
        let brand: String
        let list: [String]
    }
}
