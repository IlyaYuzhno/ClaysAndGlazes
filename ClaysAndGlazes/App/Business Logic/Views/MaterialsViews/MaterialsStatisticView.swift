//
//  MaterialsStatisticView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

import UIKit

class MaterialsStatisticView: UIView {

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Статистика"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .systemGray
        return label
    }()

    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        return view
    }()

    var infoLabel: UILabelPadded = {
        let label = UILabelPadded()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Здесь пока что пусто"
        label.backgroundColor = .clear
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(infoLabel)
        addSubviews(label, mainView)

        infoLabel.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true

        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true

        mainView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }



    

}
