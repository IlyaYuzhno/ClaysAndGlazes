//
//  MaterialsStatisticView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

import UIKit

class MaterialsStatisticView: UIView {

    private var titleLabel: UILabel = {
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
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        return view
    }()

    var infoLabel: UILabelPadded = {
        let label = UILabelPadded()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Здесь пока что пусто"
        label.backgroundColor = .clear
        label.textAlignment = .natural
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 0
        return label
    }()

    let topFiveTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
        return tableView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(topFiveTableView)
        addSubviews(titleLabel, mainView)

        topFiveTableView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        topFiveTableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        topFiveTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive = true
        topFiveTableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        mainView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
}
