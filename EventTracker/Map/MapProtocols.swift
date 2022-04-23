//
//  MapProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

protocol MapModuleInput {
	var moduleOutput: MapModuleOutput? { get }
}

protocol MapModuleOutput: AnyObject {
}

protocol MapViewInput: AnyObject {
    func reloadData(with newLocation: Coordinates)
}

protocol MapViewOutput: AnyObject {
    var mapPlaces: [MapPlace] { get }
    func didLoad()
    func didTapCell(poster: PosterViewModel)
}

protocol MapInteractorInput: AnyObject {
    func getCityService()
    func isInFavorites(poster: PosterViewModel)
}

protocol MapInteractorOutput: AnyObject {
    func setCityService(cityService: String)
    func didReceive(error: Error)
    func isInFavorites(poster: PosterViewModel)
    func notInFavorites(poster: PosterViewModel)
}

protocol MapRouterInput: AnyObject {func showAlertErrorMessage(with message: String)
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: MapPresenter)
}
