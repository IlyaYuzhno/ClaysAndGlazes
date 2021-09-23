//
//  Extension + AddMaterialViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 10.08.2021.
//

import UIKit


// MARK: - UIPickerView datasource
extension AddMaterialViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel?.pickerItems.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.pickerItems[row]
    }
}

// MARK: - UITextField delegate
extension AddMaterialViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        
        return true
    }
    
    // Correcting "," to "." in quantity
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 100 {
        if string.contains(",") {
              textField.text = textField.text! + "."
              return false
          }
        }
          return true

  }
    
}

// MARK: - Notifications handling
extension AddMaterialViewController {
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }

    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
