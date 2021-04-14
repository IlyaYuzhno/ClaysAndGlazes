//
//  Extensions.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 13.04.2021.
//

import Foundation
import UIKit

// MARK: Sections stuff
extension UITableViewController {
    struct Section {
        var name: String
        var info: [String]
        var items: [String]
        var collapsed: Bool

        init(name: String, items: [String], info: [String], collapsed: Bool = true) {
            self.name = name
            self.items = items
            self.info = info
            self.collapsed = collapsed
        }
    }
}

// MARK: - UIColors
extension UIColor {
  static let BackgroundColor1: UIColor = UIColor(named: "BackgroundColor1")!
  static let BackgroundColor2: UIColor = UIColor(named: "BackgroundColor2")!
  static let SectionColor: UIColor = UIColor(named: "SectionColor")!
  static let SearchBarColor: UIColor = UIColor(named: "SearchBarColor")!
}

// MARK: - Hide keyboard
extension UITableViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
