//
//  MapPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

final class MapPresenter {
	weak var view: MapViewInput?
    weak var moduleOutput: MapModuleOutput?

	private let router: MapRouterInput
	private let interactor: MapInteractorInput

    init(router: MapRouterInput, interactor: MapInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MapPresenter: MapModuleInput {
}

extension MapPresenter: MapViewOutput {
}

extension MapPresenter: MapInteractorOutput {
}

extension MapPresenter: PosterModuleOutput {
    func setNewPosters(posters: [PosterResults]) {
    }

    func setNewCity(cityService: String) {
    }

}
