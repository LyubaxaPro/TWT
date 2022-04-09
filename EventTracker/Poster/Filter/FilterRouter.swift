//
//  FilterRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class FilterRouter {
    weak var sourceViewController: UIViewController?
}

extension FilterRouter: FilterRouterInput {
    func showCitiesFilter(output: FilterPresenter, city: String) {
        let container = CitiesFilterContainer.assemble(with: CitiesFilterContext(moduleOutput: output, previousCity: city))
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }

    func showCategoriesFilter(output: FilterPresenter, categories: [String : Bool]) {
        let container = CategoriesFilterContainer.assemble(with: CategoriesFilterContext(moduleOutput: output, previousCategories: categories))
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }

    func closeFilter() {
        sourceViewController?.navigationController?.popViewController(animated: true)
    }
}
