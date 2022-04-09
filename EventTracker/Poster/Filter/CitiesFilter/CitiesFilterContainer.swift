//
//  CitiesFilterContainer.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class CitiesFilterContainer {
    let input: CitiesFilterModuleInput
    let viewController: UIViewController
    private(set) weak var router: CitiesFilterRouterInput!

    class func assemble(with context: CitiesFilterContext) -> CitiesFilterContainer {
        let router = CitiesFilterRouter()
        let interactor = CitiesFilterInteractor()
        let presenter = CitiesFilterPresenter(router: router, interactor: interactor, previousCity: context.previousCity)
        let viewController = CitiesFilterViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter

        return CitiesFilterContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: CitiesFilterModuleInput, router: CitiesFilterRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct CitiesFilterContext {
    weak var moduleOutput: CitiesFilterModuleOutput?
    var previousCity: String
}
