//
//  ClayCell.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 31.03.2021.
//

import UIKit

class ClayCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(item: String) {
        accessoryType = .detailButton
        accessibilityIdentifier = "clayCell"
        backgroundColor = .white
        textLabel?.numberOfLines = 0
        textLabel?.text = item
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5))
    }


}
