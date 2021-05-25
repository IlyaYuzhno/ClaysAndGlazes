//
//  ClayInfoView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 02.04.2021.
//

import UIKit

protocol ClayInfoViewDelegate: class {
    func hideNavigationBar(sender: UITapGestureRecognizer)
    func showNavigationBar(sender: UITapGestureRecognizer)
}

class ClayInfoView: UIView {

    var clayInfo: String?
    var clay: String?
    weak var delegate: ClayInfoViewDelegate?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(openImageFullSize(sender:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()

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

    // MARK: - Init
    init(frame: CGRect, clayName: String, clayInfo: String) {
        self.clay = clayName
        self.clayInfo = clayInfo
        super.init(frame: frame)
        setupViews()
        setupConstraints()

        NotificationCenter.default.addObserver(self, selector: #selector(self.setLabelText(_:)), name: NSNotification.Name(rawValue: "showInfoView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setLabelText(_:)), name: NSNotification.Name(rawValue: "showGlazeInfoView"), object: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup Views
    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        addSubviews(imageView, clayNameLabel, clayInfoLabel, line)
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            line.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            line.centerXAnchor.constraint(equalTo: centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 100),
            line.heightAnchor.constraint(equalToConstant: 8),

            clayNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            clayNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            clayNameLabel.widthAnchor.constraint(equalTo: widthAnchor),

            imageView.topAnchor.constraint(equalTo: clayNameLabel.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 190),
            imageView.heightAnchor.constraint(equalToConstant: 190),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            clayInfoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            clayInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            clayInfoLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20)
        ])
    }

    @objc func openImageFullSize(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        newImageView.enableZoom()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
        tap.cancelsTouchesInView = false
        newImageView.addGestureRecognizer(tap)
        addSubview(newImageView)

        // Hide Nav bar on ClaysTableViewController when show full screen image
        delegate?.hideNavigationBar(sender: sender)
    }

    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        // Show Nav and Tab bars on ClaysTableViewController when close full screen image
        delegate?.showNavigationBar(sender: sender)
        
        sender.view?.removeFromSuperview()
    }

    @objc private func setLabelText(_ notification: NSNotification) {

        if let clayName = notification.userInfo?["clayName"] as? String {
            clayNameLabel.text = clayName

            //Get image from Firebase and set to imageview
            Interactor.getClayImageFromFirebase(imageName: extractClayImageName(from: clayName), imageView: imageView)
        }

        if let clayInfo = notification.userInfo?["clayInfo"] as? String {
            clayInfoLabel.text = clayInfo
        }

        if let glazeName = notification.userInfo?["glazeName"] as? String {
            clayNameLabel.text = glazeName

            //Get image from Firebase and set to imageview
            Interactor.getGlazeImageFromFirebase(imageName: extractImageName(from: glazeName), imageView: imageView)
        }

        if let glazeInfo = notification.userInfo?["glazeInfo"] as? String {
            clayInfoLabel.text = glazeInfo
        }

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
