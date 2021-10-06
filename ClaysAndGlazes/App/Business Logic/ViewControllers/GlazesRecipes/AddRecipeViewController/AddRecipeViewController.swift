//
//  AddRecipeViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.10.2021.
//

import UIKit

class AddRecipeViewController: UIViewController {

    let segerFormulaView = SegerFormulaView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let addMaterialsToRecipeView = AddMaterialsToRecipeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setupView()

        
    }

    private func setupView() {
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "ДОБАВЛЯЕМ РЕЦЕПТ"
        view.addSubviews(segerFormulaView, addMaterialsToRecipeView)

        segerFormulaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segerFormulaView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segerFormulaView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segerFormulaView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        addMaterialsToRecipeView.topAnchor.constraint(equalTo: segerFormulaView.bottomAnchor).isActive = true
        addMaterialsToRecipeView.leadingAnchor.constraint(equalTo: segerFormulaView.leadingAnchor).isActive = true
        addMaterialsToRecipeView.trailingAnchor.constraint(equalTo: segerFormulaView.trailingAnchor).isActive = true
        addMaterialsToRecipeView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

}



