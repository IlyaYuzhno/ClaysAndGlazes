//
//  Response.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import Foundation


struct Response: Codable {
    
    let brand: String
    let clay: String
   // let info: String
    let temperature: [String: Crackle]

    struct Crackle: Codable {
        let mnogo: [String]
        let malo: [String]
        let no: [String]
    }

}
