//
//  UsedMaterialViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 03.09.2021.
//

import UIKit

class UsedMaterialViewViewModel: UsedMaterialViewViewModelType {

    var dropDownItemsArray: [String] = []
    var materialsDictionary: [String : Material] = [:]
    var statisticController: StatisticControllerType?
    let storageKey = MaterialsLocalStorageKeys.materialsKey

    init() {
        statisticController = StatisticController()
    }

    func loadData(view: UsedMaterialView) {
        MaterialsLocalStorageService.retrieveMaterialsData() { [weak self] materials, _ in

            let items = materials.map { $0.map { $0.name }}?.removingDuplicates()
            let quantity = materials.map { $0.map { $0.quantity }}
            let info = materials.map { $0.map { $0.info }}
            let type = materials.map { $0.map { $0.type }}
            let marked = materials.map { $0.map { $0.marked }}
            let unit = materials.map { $0.map { $0.unit }}

            var materials: [Material] = []

            guard let names = items, let quant = quantity, let inform = info, let t = type, let mark = marked, let un = unit  else { return }

            (0..<names.count).forEach { i in
                let material = Material(type: t[i], name: names[i], quantity: quant[i], unit: un[i], info: inform[i], marked: mark[i])
                materials.append(material)
            }
            self?.dropDownItemsArray = names
            view.optionArray = names

            self?.materialsDictionary = Dictionary(uniqueKeysWithValues: zip(names, materials))
        }
    }

    func saveButtonTapped(stack: UIStackView, self: UIViewController) {

        (0..<stack.arrangedSubviews.count).forEach { i in
            let view = stack.arrangedSubviews[i] as! UsedMaterialView
            let selectedText = view.selectedText

            // Remove item from storage
            guard let itemToRemove = materialsDictionary[selectedText] else { return }
            MaterialsLocalStorageService.removeItemInStorage(itemToRemove: itemToRemove, key: storageKey)

            // Correcting quantity
            let newQuantity:Float? = Float(view.materialQuantityTextField.text ?? "0")
            let oldQuantity = Float(itemToRemove.quantity)
            var updatedQuantity = oldQuantity - (newQuantity ?? 0)
            if updatedQuantity <= 0 { updatedQuantity = 0 }

            // Create new item
            let type = materialsDictionary[selectedText]?.type
            let name = selectedText
            let info = materialsDictionary[selectedText]?.info
            let marked = materialsDictionary[selectedText]?.marked
            let unit = materialsDictionary[selectedText]?.unit

            let updatedItem = Material(type: type ?? "", name: name, quantity: updatedQuantity , unit: unit ?? "", info: info ?? "", marked: marked ?? false)

            // Save new item to storage
            MaterialsLocalStorageService.saveDataToStorage(object: updatedItem, key: storageKey)

            // Save updated item info to statistic
            saveToStatistic(name: name, quantity: newQuantity ?? 0, unit: unit ?? "")
        }
        showSupportingView(self: self)
    }

    // Save updated item info to statistic
    private func saveToStatistic(name: String, quantity: Float, unit: String) {

        let statisticItem = MaterialStatisticItem(name: name, quantity: quantity, unit: unit)

        statisticController?.saveToStatistic(itemToSave: statisticItem)
    }

    private func showSupportingView(self: UIViewController) {
        let supportingView = SupportingView(frame: CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 200, height: 200), text: "Сохранено")

        self.view.addSubview(supportingView)

        supportingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        supportingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        supportingView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        supportingView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true

        Animation.setBlur(view: self.view, contentView: supportingView)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            Animation.removeBlur()
        }
    }

}
