//
//  MaterialsListMainViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.08.2021.
//

import UIKit

class MaterialsListMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    private var addMaterialsView: MaterialsListTileView = {
        let view = MaterialsListTileView()
        view.setTitle("Добавить материал", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.addTarget(self, action: #selector(addMaterialButtonTapped), for: .touchUpInside)
        return view
    }()

    private var materialsRemainView: MaterialsListTileView = {
        let view = MaterialsListTileView()
        view.setTitle("Остатки", for: .normal)
        view.addTarget(self, action: #selector(materialsRemainButtonTapped), for: .touchUpInside)
        return view
    }()

    private var usedMaterialsView: MaterialsListTileView = {
        let view = MaterialsListTileView()
        view.setTitle("Использовано", for: .normal)
        view.addTarget(self, action: #selector(usedMaterialsButtonTapped), for: .touchUpInside)
        return view
    }()

    private var purchaseListView: MaterialsListTileView = {
        let view = MaterialsListTileView()
        view.setTitle("Список   покупок", for: .normal)
        view.addTarget(self, action: #selector(purchaseListButtonTapped), for: .touchUpInside)
        return view
    }()

    private var upperStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var lowerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    func setupView() {
        view.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "МОИ МАТЕРИАЛЫ"
        setupViews()
    }

    func setupViews() {
        upperStack.addArrangedSubview(addMaterialsView)
        upperStack.addArrangedSubview(materialsRemainView)
        lowerStack.addArrangedSubview(usedMaterialsView)
        lowerStack.addArrangedSubview(purchaseListView)

        view.addSubview(upperStack)
        view.addSubview(lowerStack)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint .activate([
            addMaterialsView.heightAnchor.constraint(equalToConstant: 100),
            addMaterialsView.widthAnchor.constraint(equalToConstant: 100),

            materialsRemainView.heightAnchor.constraint(equalToConstant: 100),
            materialsRemainView.widthAnchor.constraint(equalToConstant: 100),

            usedMaterialsView.heightAnchor.constraint(equalToConstant: 100),
            usedMaterialsView.widthAnchor.constraint(equalToConstant: 100),

            purchaseListView.heightAnchor.constraint(equalToConstant: 100),
            purchaseListView.widthAnchor.constraint(equalToConstant: 100),

            upperStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            upperStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            upperStack.heightAnchor.constraint(equalToConstant: 100),
            upperStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),

            lowerStack.leadingAnchor.constraint(equalTo: upperStack.leadingAnchor),
            lowerStack.trailingAnchor.constraint(equalTo: upperStack.trailingAnchor),
            lowerStack.topAnchor.constraint(equalTo: upperStack.bottomAnchor, constant: 20)

        ])
    }

    @objc func addMaterialButtonTapped() {
        // Go to add material VC
        let addMaterialViewController = AddMaterialViewController()
        self.navigationController?.pushViewController(addMaterialViewController, animated: true)
    }

    @objc func materialsRemainButtonTapped() {
        // Go to add materials table view VC
        let materialsListTableViewController = MaterialsListTableViewController()
        self.navigationController?.pushViewController(materialsListTableViewController, animated: true)
    }

    @objc func usedMaterialsButtonTapped() {
        // Go to used materials table view VC
        let usedMaterialViewController = EditMaterialViewController()
        self.navigationController?.pushViewController(usedMaterialViewController, animated: true)
    }

    @objc func purchaseListButtonTapped() {


    }


    


}
