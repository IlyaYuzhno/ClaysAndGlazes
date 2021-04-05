//
//  Animation.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 05.04.2021.
//

import Foundation
import UIKit


class Animation {
    
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


}
