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


extension UIView {
  func animateBorderColor(toColor: UIColor, duration: Double) {
    let animation = CABasicAnimation(keyPath: "borderColor")
    animation.fromValue = layer.borderColor
    animation.toValue = toColor.cgColor
    animation.duration = duration
    layer.add(animation, forKey: "borderColor")
    layer.borderColor = toColor.cgColor
  }
}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(self).isSubset(of: nums)
    }
}

extension UITableView {
    func setBackgroundImage(imageName: String) {
        let background = UIImage(named: imageName)
        var imageView : UIImageView!
        imageView = UIImageView(frame: bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = center
        backgroundView = imageView
    }
}

extension UIViewController {
    func setBackgroundImage() {
        let background = UIImage(named: "backgroundImage")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
}

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: 100, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}

