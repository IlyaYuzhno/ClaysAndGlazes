//
//  Response.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import Foundation


class Response: Codable {

    let clay: String
    let temperature: [String: Crackle]

    struct Crackle: Codable {
        let mnogo: [String]
        let malo: [String]
        let no: [String]
    }

}
