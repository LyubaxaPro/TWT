//
//  FilterContainer.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class FilterContainer {
    let input: FilterModuleInput
    let viewController: UIViewController
    private(set) weak var router: FilterRouterInput!

    class func assemble(with context: FilterContext) -> FilterContainer {
        let router = FilterRouter()
        let interactor = FilterInteractor()
        let presenter = FilterPresenter(router: router, interactor: interactor)
        let viewController = FilterViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        presenter.filterInfo.city.cityInfo = context.cityService
        presenter.filterInfo.city.cityName = ServiceData.shared.getCities().someKey(forValue: context.cityService) ?? ""

        interactor.output = presenter
        router.sourceViewController = viewController

        return FilterContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: FilterModuleInput, router: FilterRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct FilterContext {
    weak var moduleOutput: FilterModuleOutput?
    var cityService: String
}
