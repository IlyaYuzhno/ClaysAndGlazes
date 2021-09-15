//
//  MaterialsListMainViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 30.08.2021.
//

import UIKit

class MaterialsListMainViewController: UIViewController {

    var topConstraint: NSLayoutConstraint!
    var startingConstant: CGFloat  = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private var basicView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .SearchBarColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    private var addMaterialsView: MainMaterialsListTileView = {
        let view = MainMaterialsListTileView()
        view.imageView.image = UIImage(named: "addMaterialIcon.png")
        view.titleLabel.text = "Добавить материал"
        view.isUserInteractionEnabled = true
        return view
    }()

    private var materialsRemainView: MainMaterialsListTileView = {
        let view = MainMaterialsListTileView()
        view.imageView.image = UIImage(named: "handsWithClayIcon.png")
        view.titleLabel.text = "Остатки"
        view.isUserInteractionEnabled = true
        view.imageTrailingOffset = -40
        return view
    }()

    private var usedMaterialsView: MainMaterialsListTileView = {
        let view = MainMaterialsListTileView()
        view.imageView.image = UIImage(named: "usedMaterialsIcon.png")
        view.titleLabel.text = "Использовано"
        view.isUserInteractionEnabled = true
        view.imageTrailingOffset = -75
        return view
    }()

    private var purchaseListView: MainMaterialsListTileView = {
        let view = MainMaterialsListTileView()
        view.imageView.image = UIImage(named: "purchaseListIcon200x200.png")
        view.titleLabel.text = "Список\nпокупок"
        view.isUserInteractionEnabled = true
        return view
    }()

    private var upperStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 20
        stack.isUserInteractionEnabled = true
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
        view.backgroundColor = .SectionColor
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "МОИ МАТЕРИАЛЫ"
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(scrollBasicView(sender:)))
        basicView.addGestureRecognizer(panGesture)
        setupViews()
    }

    func setupViews() {
        upperStack.addArrangedSubview(addMaterialsView)
        upperStack.addArrangedSubview(materialsRemainView)
        lowerStack.addArrangedSubview(usedMaterialsView)
        lowerStack.addArrangedSubview(purchaseListView)

        basicView.addSubview(upperStack)
        basicView.addSubview(lowerStack)

        view.addSubview(basicView)

        addRecognizers()

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

            basicView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            basicView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            upperStack.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 20),
            upperStack.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -20),
            upperStack.heightAnchor.constraint(equalToConstant: 150),
            upperStack.centerXAnchor.constraint(equalTo: basicView.centerXAnchor),
            upperStack.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 20),

            lowerStack.leadingAnchor.constraint(equalTo: upperStack.leadingAnchor),
            lowerStack.trailingAnchor.constraint(equalTo: upperStack.trailingAnchor),
            lowerStack.heightAnchor.constraint(equalTo: upperStack.heightAnchor),
            lowerStack.topAnchor.constraint(equalTo: upperStack.bottomAnchor, constant: 20)
        ])

        topConstraint = basicView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        topConstraint.isActive = true
    }

    private func addRecognizers() {
        let addMaterialsViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addMaterialButtonTapped(sender:)))
        addMaterialsView.addGestureRecognizer(addMaterialsViewTapGestureRecognizer)

        let materialsRemainsTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(materialsRemainButtonTapped(sender:)))
        materialsRemainView.addGestureRecognizer(materialsRemainsTapGestureRecognizer)

        let usedMaterialsTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(usedMaterialsButtonTapped(sender:)))
        usedMaterialsView.addGestureRecognizer(usedMaterialsTapGestureRecognizer)

        let purchaseListTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(purchaseListButtonTapped(sender:)))
        purchaseListView.addGestureRecognizer(purchaseListTapGestureRecognizer)

    }

    @objc func addMaterialButtonTapped(sender: UITapGestureRecognizer) {
        // Go to add material VC
        let addMaterialViewController = AddMaterialViewController()
        self.navigationController?.pushViewController(addMaterialViewController, animated: true)
    }

    @objc func materialsRemainButtonTapped(sender: UITapGestureRecognizer) {
        // Go to add materials table view VC
        let materialsListTableViewController = MaterialsListTableViewController()
        self.navigationController?.pushViewController(materialsListTableViewController, animated: true)
    }

    @objc func usedMaterialsButtonTapped(sender: UITapGestureRecognizer) {
        // Go to used materials table view VC
        let usedMaterialViewController = UsedMaterialsViewController()
        self.navigationController?.pushViewController(usedMaterialViewController, animated: true)
    }

    @objc func purchaseListButtonTapped(sender: UITapGestureRecognizer) {
        // Go to purchase list table view VC
        let purchaseListTableViewController = PurchaseListTableViewController()
        self.navigationController?.pushViewController(purchaseListTableViewController, animated: true)
    }

    // MARK: - Scroll basic view
    @objc func scrollBasicView(sender: UIPanGestureRecognizer) {

        switch sender.state {
        case .began:
            startingConstant = topConstraint.constant
        case .changed:
            let translation = sender.translation(in: view)

            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: .curveLinear) {
                self.view.layoutIfNeeded()
                self.topConstraint.constant = self.startingConstant + translation.y
            }
        default:
            break
        }
    }


}
