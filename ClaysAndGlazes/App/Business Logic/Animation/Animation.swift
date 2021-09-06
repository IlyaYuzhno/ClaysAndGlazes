//
//  Animation.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 05.04.2021.
//

import Foundation
import UIKit


final class Animation {
    
    @available(iOS 13.0, *)
    static var blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
    static var visualEffect = UIVisualEffectView()

    // MARK: Show animated view
    class func showView(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: .curveEaseIn, animations: {

            view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)

        }, completion: nil)
    }

    // MARK: Hide animated view
    class func hideView(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: .curveEaseIn, animations: {

            view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height + 20, width: view.frame.width, height: view.frame.height)

        }, completion: nil)
    }

    // MARK: Set blur
    @available(iOS 13.0, *)
    class func setBlur(view: UIView, contentView: UIView) {

        visualEffect = UIVisualEffectView(effect: blur)
        visualEffect.frame = view.bounds

        view.addSubview(visualEffect)
        visualEffect.contentView.addSubview(contentView)
    }

    // MARK: Remove blur
   class func removeBlur() {

        visualEffect.removeFromSuperview()
    }


    // MARK: Animate border color circularry
   class func circularBorderAnimate(sender: UIView) {
    let strokeLayer = CAShapeLayer()
        strokeLayer.fillColor = UIColor.clear.cgColor
        strokeLayer.strokeColor = UIColor.red.cgColor
        strokeLayer.lineWidth = 2

        // Create a rounded rect path using button's bounds.
        strokeLayer.path = CGPath.init(roundedRect: sender.bounds, cornerWidth: 10, cornerHeight: 10, transform: nil) // same path like the empty one ...
        // Add layer to the button
        sender.layer.addSublayer(strokeLayer)

        // Create animation layer and add it to the stroke layer.
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeLayer.add(animation, forKey: "circleAnimation")
    }


}
