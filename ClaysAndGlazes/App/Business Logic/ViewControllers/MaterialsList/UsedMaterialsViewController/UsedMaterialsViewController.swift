//
//  UsedMaterialsViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 31.08.2021.
//

import UIKit

class UsedMaterialsViewController: UIViewController {

    var dropDownViewIndex = 0

    var viewModel: UsedMaterialViewViewModelType?

    var usedMaterialView: UsedMaterialView = {
        let item = UsedMaterialView()
        return item
    }()

    var describingView: DescribingView = {
        let view = DescribingView()
        return view
    }()

    private var scrollView = UIScrollView()

    var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var addUsedMaterialButton: UIButton = {
        let button = UIButton(type: .custom)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "plusButton.png"), for: .normal)
        button.layer.cornerRadius = 10

        button.backgroundColor = .white
        button.alpha = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addUsedMaterialView), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UsedMaterialViewViewModel()
        setupView()

        viewModel?.fetchData(view: usedMaterialView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize.height = 2000
        scrollView.contentSize.width = scrollView.frame.size.width
        scrollView.contentMode = .scaleAspectFit
    }

    func setupView() {
        view.backgroundColor = .BackgroundColor1
        title = "ИСПОЛЬЗОВАНО"
        usedMaterialView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentMode = .scaleAspectFit
        addOkButton()

        stack.addArrangedSubview(usedMaterialView)
        scrollView.addSubview(stack)
        scrollView.addSubview(addUsedMaterialButton)
        view.addSubview(describingView)
        view.addSubview(scrollView)

        describingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        describingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        describingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        describingView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        scrollView.topAnchor.constraint(equalTo: describingView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        usedMaterialView.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
        usedMaterialView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stack.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20).isActive = true

        addUsedMaterialButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20).isActive = true
        addUsedMaterialButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        addUsedMaterialButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        addUsedMaterialButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    // MARK: - Add new used material view to stack
    @objc func addUsedMaterialView() {
        guard let viewModel = viewModel else { return }
        let newItem = UsedMaterialView()
        newItem.delegate = self
        newItem.optionArray = viewModel.dropDownItemsArray
        dropDownViewIndex += 1
        newItem.dropDown.tag = dropDownViewIndex

        stack.addArrangedSubview(newItem)

        newItem.widthAnchor.constraint(equalTo: usedMaterialView.widthAnchor).isActive = true
        newItem.heightAnchor.constraint(equalTo: usedMaterialView.heightAnchor).isActive = true
    }

    // MARK: - Add OK button to navbar
    private func addOkButton() {
        let okButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        okButton.setImage(UIImage(named: "okButton25x25.png"), for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: okButton)
    }

    @objc private func okButtonTapped() {
        guard let viewModel = viewModel else { return }
        viewModel.okButtonTapped(stack: stack, self: self)
    }


}

// MARK: - Show material quantity depending on dropDown index
extension UsedMaterialsViewController: UsedMaterialViewProtocol {
    func showQuantity(for selectedText: String, index: Int) {
        let unit = viewModel?.materialsDictionary[selectedText]?.unit
        let view = stack.arrangedSubviews[index] as! UsedMaterialView
        view.itemUnit = unit ?? ""
    }
}
