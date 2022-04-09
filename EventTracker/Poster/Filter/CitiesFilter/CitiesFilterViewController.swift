//
//  CitiesFilterViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class CitiesFilterViewController: UIViewController {
    private let output: CitiesFilterViewOutput
    let tableView = UITableView()

    init(output: CitiesFilterViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Города"

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(CitiesFilterCell.self, forCellReuseIdentifier: "CitiesFilterCell")
        view.addSubview(tableView)

        tableView.separatorStyle = .none
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
}

extension CitiesFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.defaultCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesFilterCell", for: indexPath) as? CitiesFilterCell
        else {
            return .init()
        }

        cell.configure(with: output.defaultCities[indexPath.row])
        if output.defaultCities[indexPath.row] == output.chosenCity {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didChangeCity(city: output.defaultCities[indexPath.row])
    }
}

extension CitiesFilterViewController: CitiesFilterViewInput {
    func reloadTable() {
        self.tableView.reloadData()
    }

}
