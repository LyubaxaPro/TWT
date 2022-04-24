//
//  CategoriesFilterViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit
/// Контроллер модуля экрана фильтров по категориям
final class CategoriesFilterViewController: UIViewController {
    private let output: CategoriesFilterViewOutput
    /// Таблица
    let tableView = UITableView()

    /// Инициализация
    init(output: CategoriesFilterViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Установка параметров элементов
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Категории"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesFilterCell.self, forCellReuseIdentifier: "CategoriesFilterCell")
        view.addSubview(tableView)

        tableView.separatorStyle = .none
    }

    /// Размещение элементов на экране
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
}

/// Работа с таблицей
extension CategoriesFilterViewController: UITableViewDelegate, UITableViewDataSource {
    /// Количество секций
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.categories.count
    }

    /// Установка ячейки для таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesFilterCell", for: indexPath) as? CategoriesFilterCell else {
            return .init()
        }
        cell.output = self
        let title = output.categories[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: title, isChosen: output.chosenCategories[title] ?? false)
        return cell
    }
}

/// Получение информации от взаимодействия пользователя с ячейкой
extension CategoriesFilterViewController: CategoriesFilterCellOutput {
    /// Выбрана новая категория
    func didСhooseCheckmark(with category: String) {
        output.didСhooseCheckmark(with: category)
    }

    /// Отменен выбор категории
    func didСanceledCheckmark(with category: String) {
        output.didСanceledCheckmark(with: category)
    }

}

/// Получение информации от упраляющего класса
extension CategoriesFilterViewController: CategoriesFilterViewInput {
    /// Обновить таблицу
    func reloadTable() {
        tableView.reloadData()
    }
}

