//
//  Extensions.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 13.04.2021.
//

import Foundation
import UIKit

// MARK: - Sections stuff
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

// MARK: - UIView
public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }

    func extractImageName(from string: String) -> String {
        let delimiter = " "
        let imageName = string.components(separatedBy: delimiter)
        return (imageName[0])
    }

    func extractClayImageName(from string: String) -> String {
        let delimiter = ","
        let imageName = string.components(separatedBy: delimiter)
        return (imageName[0])
    }
}

// MARK: - UIImageView
extension UIImageView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }

    @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}



