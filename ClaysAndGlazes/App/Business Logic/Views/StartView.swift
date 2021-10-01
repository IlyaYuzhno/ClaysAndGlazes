//
//  StartView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 08.04.2021.
//
import UIKit

protocol StartViewDelegate: AnyObject {
    func startViewButtonPressed()
}

class StartView: UIView {

    let title = "Вы установили справочник керамиста."
    let text = "Приложение содержит справочную информацию о характеристиках различных масс и глазурей и их сочетаниях при различных температурах обжига.\n\nВсе данные взяты из разрозненных открытых источников и сведены в этом приложении в удобном виде.\n\nТакже в приложении вы можете создать инвентарный список ваших материалов и управлять им."
    weak var delegate: StartViewDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .BackgroundColor2
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(okButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        addSubviews(titleLabel, textLabel, okButton)
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            okButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            okButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            okButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 50),
            okButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func okButtonPressed(sender: UIButton) {
        delegate?.startViewButtonPressed()
    }


}
