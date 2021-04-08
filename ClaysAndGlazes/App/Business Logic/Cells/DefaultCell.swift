//
//  DefaultCell.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 07.04.2021.
//

import UIKit

class DefaultCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(item: String) {
        backgroundColor = .white
        textLabel?.numberOfLines = 0
        textLabel?.text = item

        switch textLabel?.text {
        case "No info available...":
            isUserInteractionEnabled = false
            textLabel?.font = .italicSystemFont(ofSize: 16)
        default:
            break
        }
    }

}
