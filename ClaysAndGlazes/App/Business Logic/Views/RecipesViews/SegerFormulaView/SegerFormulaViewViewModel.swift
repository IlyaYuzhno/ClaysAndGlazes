//
//  SegerFormulaViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.10.2021.
//

import UIKit

protocol SegerFormulaViewViewModelType: AnyObject {
    func chemicalFormulaString(from str: String) -> NSAttributedString
}

class SegerFormulaViewViewModel: SegerFormulaViewViewModelType {
    
    func chemicalFormulaString(from str: String) -> NSAttributedString {
        let result = NSMutableAttributedString()
        var array: [Character] = []

        for char in str {
            array.append(char)
        }

        for item in array {
            if item.isNumber {
                let attributedNumber = NSMutableAttributedString(string: String(item), attributes: [.font : UIFont.systemFont(ofSize: 12)])
                result.append(attributedNumber)
            } else {
                let attributedCharacter = NSMutableAttributedString(string: String(item), attributes: [.font : UIFont.systemFont(ofSize: 20)])
                result.append(attributedCharacter)
            }
        }
        return result
    }


}
