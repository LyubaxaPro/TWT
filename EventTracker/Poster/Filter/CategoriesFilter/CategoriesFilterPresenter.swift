//
//  CategoriesFilterPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import Foundation

/// Управляющий класс модуля экрана фильтра по категориям
final class CategoriesFilterPresenter {
    weak var view: CategoriesFilterViewInput?
    weak var moduleOutput: CategoriesFilterModuleOutput?

    /// Массив доступных категорий
    private (set) var categories: [String] = []
    /// Выбранные категории
    private (set) var chosenCategories: [String : Bool] = [:]

    private let router: CategoriesFilterRouterInput
    private let interactor: CategoriesFilterInteractorInput

    /// Инициализация
    init(router: CategoriesFilterRouterInput, interactor: CategoriesFilterInteractorInput, previousCategories: [String : Bool]) {
        self.router = router
        self.interactor = interactor
        categories = Array(ServiceData.shared.getCategories().keys).sorted()
        chosenCategories = previousCategories
    }
}

extension CategoriesFilterPresenter: CategoriesFilterModuleInput {
}

/// Получение информации от вью
extension CategoriesFilterPresenter: CategoriesFilterViewOutput {
    /// Выбрана новая категория
    func didСhooseCheckmark(with category: String) {
        chosenCategories[category] = true
        moduleOutput?.didChangeChosenCategories(chosenCategories: chosenCategories)
    }

    /// Отменен выбор категории
    func didСanceledCheckmark(with category: String) {
        chosenCategories[category] = false
        moduleOutput?.didChangeChosenCategories(chosenCategories: chosenCategories)
    }
}

extension CategoriesFilterPresenter: CategoriesFilterInteractorOutput {
}

