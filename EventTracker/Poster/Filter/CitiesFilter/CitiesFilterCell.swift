//
//  CitiesFilterCell.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import UIKit

/// Ячейка таблицы для экрана фильтра по городу
final class CitiesFilterCell: UITableViewCell{
    /// Заголовок
    private let titleLabel = UILabel()
    /// Инициализация
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Установка параметров элементов
    private func setup() {

        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        contentView.addSubview(titleLabel)
    }

    /// Размещение элементов на экране
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.pin
            .left(10)
            .right(10)
            .sizeToFit()
            .vCenter()
    }

    /// Конфигурация значений элементов
    func configure(with title: String) {
        titleLabel.text = title
    }
}

