//
//  ChemicalsListCell.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 11.10.2021.
//

import UIKit

class ChemicalsListCell: UITableViewCell {

    weak var viewModel: ChemicalsListCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            accessibilityIdentifier = "chemicalsListCell"
            backgroundColor = .systemBackground
            textLabel?.text = viewModel.text
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .gray
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
