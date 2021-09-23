//
//  StatisticTableViewCell.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 21.09.2021.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    weak var viewModel: StatisticTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            accessibilityIdentifier = "statisticCell"
            backgroundColor = .systemBackground
            textLabel?.numberOfLines = 0
            textLabel?.textColor = .label
            detailTextLabel?.textColor = .label
            textLabel?.text = viewModel.title
            detailTextLabel?.text = viewModel.quantity + viewModel.unit
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }


}
