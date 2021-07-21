//
//  Extensions.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 13.04.2021.
//

import Foundation
import UIKit

// MARK: - UIColors
extension UIColor {
    static let BackgroundColor1: UIColor = UIColor(named: "BackgroundColor1")!
    static let BackgroundColor2: UIColor = UIColor(named: "BackgroundColor2")!
    static let SectionColor: UIColor = UIColor(named: "SectionColor")!
    static let SearchBarColor: UIColor = UIColor(named: "SearchBarColor")!
}

// MARK: - Hide keyboard
extension UITableViewController {
    func hideKeyboardWhenTappedAroundOnTableView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAroundOnView() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
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

// MARK: - Array removing duplicates
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

