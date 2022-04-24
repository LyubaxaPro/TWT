//
//  MapContainer.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import UIKit

final class MapContainer {
    let input: MapModuleInput
	let viewController: UIViewController
    let presenter: MapPresenter
	private(set) weak var router: MapRouterInput!

	class func assemble(with context: MapContext) -> MapContainer {
        let router = MapRouter()
        let interactor = MapInteractor()
        let presenter = MapPresenter(router: router, interactor: interactor)
		let viewController = MapViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        router.sourceViewController =  viewController
        return MapContainer(view: viewController, input: presenter, router: router, presenter: presenter)
	}

    private init(view: UIViewController, input: MapModuleInput, router: MapRouterInput, presenter: MapPresenter) {
		self.viewController = view
        self.input = input
		self.router = router
        self.presenter = presenter
	}
}

struct MapContext {
	weak var moduleOutput: MapModuleOutput?
}
