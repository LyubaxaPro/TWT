//
//  EntertaimentTableViewCell.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 10.04.2022.
//

import UIKit
import Kingfisher

///Ячейка таблицы афиши
class EntertaimentTableViewCell: UITableViewCell {
    /// Тип события
    private let typeLabel = UILabel()
    /// Заголовок
    private let titleLabel = UILabel()
    /// Изображение события
    private let iconImageView = UIImageView()
    /// Цена
    private let costLabel = UILabel()
    /// Контейнер для сбора вью
    private let containerView = UIView()
    /// Возрастное ограничение
    private let age_restriction = UILabel()

    /// Инициализация
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Возможность повторного использования с обновлением контента
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        iconImageView.kf.cancelDownloadTask()
    }

    /// Установка параметров
    private func setup() {

        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        costLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        typeLabel.font = .systemFont(ofSize: 15, weight: .thin)
        costLabel.textColor = .lightGray
        typeLabel.textColor = .red
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true

        containerView.layer.cornerRadius = 10

        containerView.clipsToBounds = true

        containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

        [titleLabel, iconImageView, costLabel, typeLabel].forEach {
            containerView.addSubview($0)
        }

        contentView.addSubview(containerView)
    }

    /// Отрисовка на экране
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin
            .left(15)
            .right(15)
            .top(8)
            .bottom(8)

        iconImageView.pin
            .left()
            .size(120)
            .vCenter()

        titleLabel.pin
            .top(10)
            .after(of: iconImageView)
            .marginLeft(8)
            .right(12)
            .sizeToFit(.width)

        costLabel.pin
            .bottom(25)
            .right(12)
            .width(100)
            .height(40)

        typeLabel.pin
            .bottom(8)
            .after(of: iconImageView)
            .marginLeft(8)
            .right(12)
            .sizeToFit(.width)

    }

    /// Конфигурация значений элементов 
    func configure(with model: PosterViewModel) {
        titleLabel.text = model.short_title
        if titleLabel.text == "" {
            titleLabel.text = model.title
        }
        iconImageView.kf.setImage(with: URL(string: model.image ?? ""))

        costLabel.text = model.price
        typeLabel.text = ""
        for category in model.category{
            typeLabel.text! += category + "  "
        }

    }

}

