//
//  CategoriesFilterPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import Foundation

final class CategoriesFilterPresenter {
    weak var view: CategoriesFilterViewInput?
    weak var moduleOutput: CategoriesFilterModuleOutput?

    private (set) var categories: [String] = []
    private (set) var chosenCategories: [String : Bool] = [:]

    private let router: CategoriesFilterRouterInput
    private let interactor: CategoriesFilterInteractorInput

    init(router: CategoriesFilterRouterInput, interactor: CategoriesFilterInteractorInput, previousCategories: [String : Bool]) {
        self.router = router
        self.interactor = interactor
        categories = Array(ServiceData.shared.getCategories().keys).sorted()
        chosenCategories = previousCategories
    }
}

extension CategoriesFilterPresenter: CategoriesFilterModuleInput {
}

extension CategoriesFilterPresenter: CategoriesFilterViewOutput {
    func didСhooseCheckmark(with category: String) {
        chosenCategories[category] = true
        moduleOutput?.didChangeChosenCategories(chosenCategories: chosenCategories)
    }

    func didСanceledCheckmark(with category: String) {
        chosenCategories[category] = false
        moduleOutput?.didChangeChosenCategories(chosenCategories: chosenCategories)
    }
}

extension CategoriesFilterPresenter: CategoriesFilterInteractorOutput {
}

