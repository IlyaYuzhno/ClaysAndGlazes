//
//  RecipeCollectionViewCell.swift
//
//
//  Created by Ilya Doroshkevitch on 20.09.2021.
//

import UIKit

protocol RecipeCollectionViewCellDelegate: AnyObject {
    func likeButtonTapped()
    func shareButtonTapped()
}

class RecipeCollectionViewCell: UICollectionViewCell {

    weak var delegate:RecipeCollectionViewCellDelegate?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.backgroundColor = .green
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .BackgroundColor2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .BackgroundColor2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brown
        return button
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        label.backgroundColor = .red
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    weak var viewModel: RecipeCollectionCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            descriptionLabel.text = viewModel.description
            imageView.image = viewModel.image
        }
    }

    private func setupView() {
        contentView.addSubviews(titleLabel, imageView, likeButton, shareButton, descriptionLabel)
        contentView.backgroundColor = .systemBackground

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true

        shareButton.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60).isActive = true
        shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 30).isActive = true

        likeButton.topAnchor.constraint(equalTo: shareButton.topAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        likeButton.heightAnchor.constraint(equalTo: shareButton.heightAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }

    @objc func likeButtonTapped() {
        delegate?.likeButtonTapped()
    }

    @objc func shareButtonTapped() {
        delegate?.shareButtonTapped()
    }
}
