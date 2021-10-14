//
//  SegerFormulaView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.10.2021.
//

import UIKit

class SegerFormulaView: UIView {

    var viewModel: SegerFormulaViewViewModelType?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel = SegerFormulaViewViewModel()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 20
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let alcaliLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        return label
    }()

    private let aEarthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "RO"
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        return label
    }()

    private let stabLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textColor = .systemGreen
        return label
    }()

    private let gFormerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return label
    }()

    private let gOtherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Other"
        return label
    }()

    private let dividerLine: UIView = {
        let line = UIView()
        line.backgroundColor = .label
        line.translatesAutoresizingMaskIntoConstraints = false

        return line
    }()

    private let mainItemsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 20
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let alcaliStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.backgroundColor = .red
        stack.spacing = 2
        //stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let aEarthStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        stack.spacing = 20
        //stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let stabStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemGreen
        stack.spacing = 20
        //stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let gFormerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        stack.spacing = 20
        //stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let gOtherStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.backgroundColor = .black
        stack.spacing = 20
        //stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let alcaliToaEarthTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()

    private let alcaliToaEarthValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()

    private let siToAlTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()

    private let siToAlValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()

    private let alcaliToaEarthStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 5
        //stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let siToAlStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 5
        //stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private func setupView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        titleStack.addArrangedSubview(alcaliLabel)
        titleStack.addArrangedSubview(aEarthLabel)
        titleStack.addArrangedSubview(stabLabel)
        titleStack.addArrangedSubview(gFormerLabel)
        titleStack.addArrangedSubview(gOtherLabel)

        mainItemsStack.addArrangedSubview(alcaliStack)
        mainItemsStack.addArrangedSubview(aEarthStack)
        mainItemsStack.addArrangedSubview(stabStack)
        mainItemsStack.addArrangedSubview(gFormerStack)
        mainItemsStack.addArrangedSubview(gOtherStack)

        alcaliToaEarthStack.addArrangedSubview(alcaliToaEarthTitle)
        alcaliToaEarthStack.addArrangedSubview(alcaliToaEarthValue)

        siToAlStack.addArrangedSubview(siToAlTitle)
        siToAlStack.addArrangedSubview(siToAlValue)

        addSubviews(titleStack, dividerLine, mainItemsStack, alcaliToaEarthStack, siToAlStack)

        titleStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleStack.heightAnchor.constraint(equalToConstant: 50).isActive = true

        dividerLine.topAnchor.constraint(equalTo: titleStack.bottomAnchor).isActive = true
        dividerLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

        mainItemsStack.topAnchor.constraint(equalTo: dividerLine.bottomAnchor).isActive = true
        mainItemsStack.leadingAnchor.constraint(equalTo: titleStack.leadingAnchor).isActive = true
        mainItemsStack.trailingAnchor.constraint(equalTo: titleStack.trailingAnchor).isActive = true
        mainItemsStack.heightAnchor.constraint(equalToConstant: 50).isActive = true

        alcaliToaEarthStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        alcaliToaEarthStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

        siToAlStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        siToAlStack.bottomAnchor.constraint(equalTo: alcaliToaEarthStack.bottomAnchor).isActive = true

        alcaliLabel.attributedText = viewModel?.chemicalFormulaString(from: "R2O")
        stabLabel.attributedText = viewModel?.chemicalFormulaString(from: "R2O3")
        gFormerLabel.attributedText = viewModel?.chemicalFormulaString(from: "RO2")
        alcaliToaEarthTitle.attributedText = viewModel?.chemicalFormulaString(from: "R2O:RO")
        siToAlTitle.attributedText = viewModel?.chemicalFormulaString(from: "SiO2:Al2O3")

    }
}
