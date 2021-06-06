//
//  InformationView.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 02.04.2021.
//

import UIKit

protocol InformationViewDelegate: class {
    func hideNavigationBar(sender: UITapGestureRecognizer)
    func showNavigationBar(sender: UITapGestureRecognizer)
}

class InformationView: UIView {

    var clayInfo: String?
    var clay: String?
    var fullSizeImageView: UIImageView?
    weak var delegate: InformationViewDelegate?

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

    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = clay
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var itemInfoLabel: UILabel = {
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
        NotificationCenter.default.addObserver(self, selector: #selector(closeFullScreenImage), name: Notification.Name("CloseFullScreenImageFromClays"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeFullScreenImage), name: Notification.Name("CloseFullScreenImageFromGlazes"), object: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup Views
    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        addSubviews(imageView, itemNameLabel, itemInfoLabel, line)
    }

    // MARK: Setup UI constraints
    private func setupConstraints() {
        NSLayoutConstraint .activate([

            line.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            line.centerXAnchor.constraint(equalTo: centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 100),
            line.heightAnchor.constraint(equalToConstant: 8),

            itemNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            itemNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemNameLabel.widthAnchor.constraint(equalTo: widthAnchor),

            imageView.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 190),
            imageView.heightAnchor.constraint(equalToConstant: 190),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            itemInfoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            itemInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemInfoLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20)
        ])
    }

    @objc func openImageFullSize(sender: UITapGestureRecognizer) {
        let image = sender.view as! UIImageView
        fullSizeImageView = UIImageView(image: image.image)
        guard let fullSizeImageView = fullSizeImageView else { return }

        fullSizeImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        fullSizeImageView.backgroundColor = .black
        fullSizeImageView.contentMode = .scaleAspectFit
        fullSizeImageView.isUserInteractionEnabled = true
        fullSizeImageView.enableZoom()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
        tap.cancelsTouchesInView = false
        fullSizeImageView.addGestureRecognizer(tap)
        addSubview(fullSizeImageView)

        // Hide Nav bar on ClaysTableViewController when show full screen image
        delegate?.hideNavigationBar(sender: sender)
    }

    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        // Show Nav and Tab bars on ClaysTableViewController when close full screen image
        delegate?.showNavigationBar(sender: sender)
        
        sender.view?.removeFromSuperview()
    }

    
    @objc func closeFullScreenImage() {
        fullSizeImageView?.removeFromSuperview()
    }


    @objc private func setLabelText(_ notification: NSNotification) {

        if let clayName = notification.userInfo?["clayName"] as? String {
            itemNameLabel.text = clayName

            //Get image from Firebase and set to imageview
            Interactor.getClayImageFromFirebase(imageName: extractClayImageName(from: clayName), imageView: imageView)
        }

        if let clayInfo = notification.userInfo?["clayInfo"] as? String {
            itemInfoLabel.text = clayInfo
        }

        if let glazeName = notification.userInfo?["glazeName"] as? String {
            itemNameLabel.text = glazeName

            //Get image from Firebase and set to imageview
            Interactor.getGlazeImageFromFirebase(imageName: extractImageName(from: glazeName), imageView: imageView)
        }

        if let glazeInfo = notification.userInfo?["glazeInfo"] as? String {
            itemInfoLabel.text = glazeInfo
        }

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
