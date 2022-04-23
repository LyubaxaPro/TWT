//
//  MapPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation
import Firebase
import MapKit

final class MapPresenter {
	weak var view: MapViewInput?
    weak var moduleOutput: MapModuleOutput?
    private (set) var mapPlaces: [MapPlace] = []

	private let router: MapRouterInput
	private let interactor: MapInteractorInput
    
    private var cityService: String = "msk"
    private var coordinates: Coordinates = Coordinates(latitude: 55.7522, longitude: 37.6156)

    init(router: MapRouterInput, interactor: MapInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MapPresenter: MapModuleInput {
}

extension MapPresenter: MapViewOutput {
    func didLoad() {
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user)  in
            if user != nil {
                self?.interactor.getCityService()
            } else {
                self?.view?.reloadData(with: self?.coordinates ?? Coordinates(latitude: 55.7522, longitude: 37.6156))
            }
        }
    }
    
    func didTapCell(poster: PosterViewModel) {
        interactor.isInFavorites(poster: poster)
    }
    
}

extension MapPresenter: MapInteractorOutput {
    func isInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: true, output: self)
    }
    
    func notInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: false, output: self)
    }
    
    func setCityService(cityService: String) {
        self.cityService = cityService
        self.coordinates = ServiceData.shared.getCoordinates(city: cityService)
        self.view?.reloadData(with: coordinates)
    }
    
    func didReceive(error: Error) {
        router.showAlertErrorMessage(with: "Неожиданная ошибка")
    }
}

extension MapPresenter: PosterModuleOutput {
    func setNewCity(cityService: String) {
        self.cityService = cityService
        self.coordinates = ServiceData.shared.getCoordinates(city: cityService)
        self.view?.reloadData(with: coordinates)
    }
    
    func setNewPosters(posters: [PosterResults]) {
        let mapPlaces = posters.map { place -> MapPlace in
            let poster = PosterViewModelManager.shared.posterResultsToPosterViewModel(poster: place)
            return MapPlace(title: place.short_title, subtitle: place.title, coordinate: CLLocationCoordinate2D(latitude: place.place?.coords.lat ?? 55.751244, longitude: place.place?.coords.lon ?? 37.618423), poster: poster)
        }
        self.mapPlaces = mapPlaces
        self.view?.reloadData(with: coordinates)
    }
}

extension MapPresenter: DetailModuleOutput {
    
}
