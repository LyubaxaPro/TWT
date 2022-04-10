//
//  CategoriesFilterViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class CategoriesFilterViewController: UIViewController {
    private let output: CategoriesFilterViewOutput
    let tableView = UITableView()

    init(output: CategoriesFilterViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Категории"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesFilterCell.self, forCellReuseIdentifier: "CategoriesFilterCell")
        view.addSubview(tableView)

        tableView.separatorStyle = .none
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
}

extension CategoriesFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.categories.count
    }

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

extension CategoriesFilterViewController: CategoriesFilterCellOutput {
    func didСhooseCheckmark(with category: String) {
        output.didСhooseCheckmark(with: category)
    }

    func didСanceledCheckmark(with category: String) {
        output.didСanceledCheckmark(with: category)
    }

}

extension CategoriesFilterViewController: CategoriesFilterViewInput {
    func reloadTable() {
        tableView.reloadData()
    }
}

