//
//  FilterPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import Foundation

/// Управляющий класс экрана фильтров
final class FilterPresenter {
    weak var view: FilterViewInput?
    weak var moduleOutput: FilterModuleOutput?
    /// Информация из фильтра
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

/// Передать информацию из модуля в афишу
extension FilterPresenter: FilterViewOutput {
    /// Выбранный город
    func getCity() -> String {
        return filterInfo.city.cityName
    }

    /// Категория
    func getCategoriesIndicator() -> String {
        return filterInfo.categories.isEmpty ? "Все" : String(filterInfo.categories.count)
    }

    /// Обработка нажатия на строку таблицы
    func didTapCell(with title: String) {
        if title == "Изменить город" {
            router.showCitiesFilter(output: self, city: filterInfo.city.cityName)
        }

        if title == "Категории" {
            router.showCategoriesFilter(output: self, categories: filterInfo.categories)
        }
    }

    /// Применить фильтр
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

/// Получение информации из модуля экрана фильтра города
extension FilterPresenter: CitiesFilterModuleOutput{
    /// Выбранный город
    func serviceCity(serviceCity: String, cityName: String) {
        filterInfo.city = City(cityName: cityName, cityInfo: serviceCity)
        view?.update()
    }
}

/// Получение информации из модуля экрана фильтра категорий
extension FilterPresenter: CategoriesFilterModuleOutput{
    /// Пользователь выбрал новую категорию
    func didChangeChosenCategories (chosenCategories: [String : Bool]) {
        filterInfo.categories = chosenCategories
        view?.update()
    }
}
