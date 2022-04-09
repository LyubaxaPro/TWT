//
//  MapPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

struct Coordinates {
    var latitude: Double
    var longitude: Double
}

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
}
