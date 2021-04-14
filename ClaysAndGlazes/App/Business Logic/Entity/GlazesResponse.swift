//
//  GlazesResponse.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 14.04.2021.
//

import Foundation

struct GlazesResponse: Codable {

    let brand: String
    let glaze: String
    let info: String
    let temperature: [String: Crackle]

    struct Crackle: Codable {
        let mnogo: [String]
        let malo: [String]
        let no: [String]
    }
}
