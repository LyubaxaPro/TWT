//
//  FilterTableViewCell.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import UIKit

class TableViewCellWithLabel: UITableViewCell {
    private let titleLabel = UILabel()
    private let extraLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {

        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        contentView.addSubview(titleLabel)

        extraLabel.font = .systemFont(ofSize: 16, weight: .thin)
        extraLabel.textColor = .red
        contentView.addSubview(extraLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.pin
            .left(10)
            .right(10)
            .sizeToFit()
            .vCenter()

        extraLabel.pin
            .after(of: titleLabel)
            .margin(40)
            .vCenter()
            .sizeToFit()
    }

    func configure(with title: String, extra: String) {
        titleLabel.text = title
        extraLabel.text = extra
    }
}
