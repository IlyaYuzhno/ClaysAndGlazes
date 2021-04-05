//
//  ClayInfoView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 02.04.2021.
//

import UIKit

protocol ClayInfoViewDelegate: class {
    func okButtonPressed(sender: UISwipeGestureRecognizer)
}

class ClayInfoView: UIView {

    var clayInfo: String?
    var clay: String?
    weak var delegate: ClayInfoViewDelegate?

    private lazy var clayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = clay
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var clayInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = clayInfo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var line: UIView = {
        let line = UIView()
        line.layer.borderWidth = 10
        line.layer.borderColor = UIColor.lightGray.cgColor
        line.layer.cornerRadius = 5
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(self.okButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(frame: CGRect, clayName: String, clayInfo: String) {
        self.clay = clayName
        self.clayInfo = clayInfo
        super.init(frame: frame)
        setupViews()
        setupConstraints()

        NotificationCenter.default.addObserver(self, selector: #selector(self.setLabelText(_:)), name: NSNotification.Name(rawValue: "showInfoView"), object: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: SetupViews
    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .white
        addSubviews(clayNameLabel, clayInfoLabel, okButton, line)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        swipe.direction = .down
        addGestureRecognizer(swipe)
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            line.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            line.centerXAnchor.constraint(equalTo: centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 100),
            line.heightAnchor.constraint(equalToConstant: 8),

            clayNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            clayNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            clayNameLabel.widthAnchor.constraint(equalTo: widthAnchor),

            clayInfoLabel.topAnchor.constraint(equalTo: clayNameLabel.bottomAnchor, constant: 40),
            clayInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            clayInfoLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),

            okButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            okButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            okButton.widthAnchor.constraint(equalTo: widthAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func okButtonPressed(sender: UISwipeGestureRecognizer) {
        delegate?.okButtonPressed(sender: sender)
    }

    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        delegate?.okButtonPressed(sender: sender)
    }

    @objc private func setLabelText(_ notification: NSNotification) {

        if let clayName = notification.userInfo?["clayName"] as? String {
            clayNameLabel.text = clayName
        }

        if let clayInfo = notification.userInfo?["clayInfo"] as? String {
            clayInfoLabel.text = clayInfo
        }

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}



// MARK: - Extensions
public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
