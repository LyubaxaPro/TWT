//
//  FilterViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit
import PinLayout

final class FilterViewController: UIViewController {
    private let output: FilterViewOutput
    private let tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
    /// Возможные опции
    private let filterArray: [String] = ["Изменить город", "Категории"]
    /// Кнопка применнеия фильтров
    private let acceptButton = CustomButtonBuilder().getCustomButton(title: "Применить")

    /// Инициализация
    init(output: FilterViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Составление элементов экрана
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Фильтры"
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .white
        tableView.backgroundColor = .white

        tableView.register(TableViewCellWithLabel.self, forCellReuseIdentifier: "TableViewCellWithLabel")

        view.addSubview(tableView)
        view.addSubview(acceptButton)
        
        acceptButton.addTarget(self, action: #selector(didTapAcceptButton), for: .touchUpInside)
    }

    /// Отрисовка элементов экрана
    override func viewDidLayoutSubviews() {
        tableView.pin
            .top()
            .right()
            .left()
            .height(250)

        acceptButton.pin
            .below(of: tableView)
            .hCenter()


    }

    /// Обработка нажатия на кнопку применения фильтров
    @objc
    private func didTapAcceptButton() {
        output.didTapAcceptButton()
    }
}

/// Работа с таблицей
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    /// Количество секций в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }

    /// Стиль ячейки для строки фильтра города
    private func getCitiesCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellWithLabel", for: indexPath) as?
                TableViewCellWithLabel else {
            return .init()
            }
        cell.configure(with: filterArray[indexPath.row], extra: output.getCity())
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }

    /// Стиль ячейки для строки фильтра категорий
    private func getCategoriesCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellWithLabel", for: indexPath) as?
                TableViewCellWithLabel else {
            return .init()
            }
        cell.configure(with: filterArray[indexPath.row], extra: output.getCategoriesIndicator())
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }

    /// Таблица
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            return getCitiesCell(indexPath: indexPath)
        }

        if indexPath.row == 1 {
            return getCategoriesCell(indexPath: indexPath)
        }

        return UITableViewCell()
    }

    /// Обработка нажатия на строку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didTapCell(with: filterArray[indexPath.row])
    }
}

/// Получение данных от упраляющего класса
extension FilterViewController: FilterViewInput {
    /// Обновить таблицу
    func update() {
        tableView.reloadData()
    }
}
