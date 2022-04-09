//
//  CitiesFilterCell.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import UIKit

final class CitiesFilterCell: UITableViewCell{
    private let titleLabel = UILabel()
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
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.pin
            .left(10)
            .right(10)
            .sizeToFit()
            .vCenter()
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}

