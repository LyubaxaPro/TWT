//
//  CategoriesFilterContainer.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class CategoriesFilterContainer {
    let input: CategoriesFilterModuleInput
    let viewController: UIViewController
    private(set) weak var router: CategoriesFilterRouterInput!

    class func assemble(with context: CategoriesFilterContext) -> CategoriesFilterContainer {
        let router = CategoriesFilterRouter()
        let interactor = CategoriesFilterInteractor()
        let presenter = CategoriesFilterPresenter(router: router, interactor: interactor, previousCategories: context.previousCategories)
        let viewController = CategoriesFilterViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter

        return CategoriesFilterContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: CategoriesFilterModuleInput, router: CategoriesFilterRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct CategoriesFilterContext {
    weak var moduleOutput: CategoriesFilterModuleOutput?
    var previousCategories: [String : Bool]
}
