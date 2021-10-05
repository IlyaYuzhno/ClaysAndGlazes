//
//  ClaysGlazeItem.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 24.09.2021.
//

import Foundation

struct ClaysGlazeItem: Codable {

    let brand: String
    let item: String
    let info: String
    let temperature: [String: Crackle]

    struct Crackle: Codable {
        let mnogo: [String]
        let malo: [String]
        let no: [String]
    }
}
