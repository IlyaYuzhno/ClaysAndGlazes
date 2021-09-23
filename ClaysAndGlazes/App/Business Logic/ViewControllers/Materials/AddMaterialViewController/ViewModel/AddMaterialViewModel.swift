//
//  AddMaterialViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 29.07.2021.
//

import UIKit

class AddMaterialViewControllerViewModel: AddMaterialViewControllerViewModelType {

    var presenter: ClaysTableViewPresenterType?
    var claysList: [String] = []
    var glazesList: [String] = []

    var pickerItems = ["Массы", "Глазури", "Инструменты", "Пигменты", "Оксиды", "Краски", "Глазурная химия", "Разное"]
    var unitsDropDownListOptions = ["кг", "л", "шт", "oz."]

    func loadClaysList(completion: @escaping (() -> ()?)) {
        guard let presenter = presenter else { return }

        presenter.present() { [weak self] (_, claysList, _, _, _) in
            self?.claysList = claysList
        }
        completion()
    }

    func addNewMaterial(type: String, quantity: String, unit: String, name: String, info: String, viewController: UIViewController) {

        // Create material from item parameters
        let material = Material(type: type, name: name, quantity: Float(quantity) ?? 0, unit: unit, info: info, marked: false)

        // Save material to UserDefaults
        MaterialsLocalStorageService.save(object: material)
        showSupportingView(self: viewController)
    }

    private func showSupportingView(self: UIViewController) {
        let supportingView = SupportingView(frame: CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 200, height: 200), text: "Добавлено")

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
