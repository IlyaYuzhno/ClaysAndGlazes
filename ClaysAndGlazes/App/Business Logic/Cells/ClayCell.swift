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
        accessibilityIdentifier = "clayCell"
        contentView.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)  //.init(gray: 100, alpha: 1)
        contentView.layer.shadowOffset = .init(width: 1, height: 1)
        contentView.layer.shadowRadius = 10.0;
        contentView.layer.shadowOpacity = 1.0;
        contentView.layer.cornerRadius = 10.0;
        contentView.backgroundColor = .white
        backgroundColor = .black
        textLabel?.numberOfLines = 0
        textLabel?.text = item

    }


    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5))
    }


}
