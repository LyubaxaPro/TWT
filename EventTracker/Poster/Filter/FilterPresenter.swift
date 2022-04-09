//
//  FilterPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import Foundation

final class FilterPresenter {
    weak var view: FilterViewInput?
    weak var moduleOutput: FilterModuleOutput?
    var filterInfo = FilterInfo()

    private let router: FilterRouterInput
    private let interactor: FilterInteractorInput

    init(router: FilterRouterInput, interactor: FilterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FilterPresenter: FilterModuleInput {
}

extension FilterPresenter: FilterViewOutput {
    func getCity() -> String {
        return filterInfo.city.cityName
    }

    func getCategoriesIndicator() -> String {
        return filterInfo.categories.isEmpty ? "Все" : String(filterInfo.categories.count)
    }

    func didTapCell(with title: String) {
    }

    func didTapAcceptButton() {
        router.closeFilter()

        var categoriesArray: [String] = []
        for category in filterInfo.categories {
            if category.value {
                categoriesArray.append(ServiceData.shared.getCategories()[category.key] ?? "")
            }
        }
        moduleOutput?.setFilterValues(filterValues: FilterValues(location: filterInfo.city.cityInfo,
                                                                 categories: categoriesArray))
    }
}

extension FilterPresenter: FilterInteractorOutput {
}
