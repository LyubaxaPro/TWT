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
    private let filterArray: [String] = ["Изменить город", "Категории"]
    private let acceptButton = CustomButtonBuilder().getCustomButton(title: "Применить")

    init(output: FilterViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
    }

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

    @objc
    private func didTapAcceptButton() {
        output.didTapAcceptButton()
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }

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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            return getCitiesCell(indexPath: indexPath)
        }

        if indexPath.row == 1 {
            return getCategoriesCell(indexPath: indexPath)
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didTapCell(with: filterArray[indexPath.row])
    }
}

extension FilterViewController: FilterViewInput {
    func update() {
        tableView.reloadData()
    }
}
