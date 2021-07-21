//
//  Section.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 20.07.2021.
//

import UIKit


// MARK: - Sections stuff
extension UITableViewController {
    
    struct Section {
        var name: String
        var info: [String]
        var items: [String]
        var quantity: [String]?
        var collapsed: Bool

        init(name: String, items: [String], info: [String], collapsed: Bool = true) {
            self.name = name
            self.items = items
            self.info = info
            self.collapsed = collapsed
        }

        init(name: String, items: [String], info: [String], collapsed: Bool = true, quantity: [String]) {
            self.name = name
            self.items = items
            self.info = info
            self.collapsed = collapsed
            self.quantity = quantity
        }
    }
}
