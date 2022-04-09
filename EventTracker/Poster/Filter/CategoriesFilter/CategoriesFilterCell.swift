//
//  CategoriesFilterCell.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import UIKit

protocol CategoriesFilterCellOutput: AnyObject {
    func didСhooseCheckmark(with category: String)
    func didСanceledCheckmark(with category: String)
}

final class CategoriesFilterCell: UITableViewCell{
    weak var output: CategoriesFilterCellOutput?
    private let titleLabel = UILabel()
    private let checkmark = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {

        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        checkmark.isUserInteractionEnabled = true

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckmark))
        checkmark.addGestureRecognizer(gestureRecognizer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmark)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.pin
            .left(10)
            .right(10)
            .sizeToFit()
            .vCenter()

        checkmark.pin
            .size(40)
            .right(10)
    }

    func configure(with title: String, isChosen: Bool) {
        titleLabel.text = title
        if isChosen {
            checkmark.image = UIImage(systemName: "checkmark.square")
        } else {
            checkmark.image = UIImage(systemName: "square")
        }
    }

    @objc
    private func didTapCheckmark() {
        if checkmark.image == UIImage(systemName: "square") {
            checkmark.image = UIImage(systemName: "checkmark.square")
            output?.didСhooseCheckmark(with: titleLabel.text ?? "")
        } else {
            checkmark.image = UIImage(systemName: "square")
            output?.didСanceledCheckmark(with: titleLabel.text ?? "")
        }
    }
}

