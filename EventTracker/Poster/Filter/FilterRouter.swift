//
//  FilterRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit
/// Навигация в модуле фильтра
final class FilterRouter {
    weak var sourceViewController: UIViewController?
}

/// Получение информации от упраляющего класса модуля
extension FilterRouter: FilterRouterInput {
    /// Показать экран фильтра по городам
    func showCitiesFilter(output: FilterPresenter, city: String) {
        let container = CitiesFilterContainer.assemble(with: CitiesFilterContext(moduleOutput: output, previousCity: city))
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }

    /// Показать экран фильтра по категориям
    func showCategoriesFilter(output: FilterPresenter, categories: [String : Bool]) {
        let container = CategoriesFilterContainer.assemble(with: CategoriesFilterContext(moduleOutput: output, previousCategories: categories))
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }

    /// Закрыть экран фильтра
    func closeFilter() {
        sourceViewController?.navigationController?.popViewController(animated: true)
    }
}
