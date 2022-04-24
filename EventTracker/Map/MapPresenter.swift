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

/// Класс для связи представления и бизнес логики модуля экрана карты
final class MapPresenter {
	weak var view: MapViewInput?
    weak var moduleOutput: MapModuleOutput?
    
    /// Массив мест для отображения на карте
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
    /// Загружает данные об экране карты
    func didLoad() {
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user)  in
            if user != nil {
                self?.interactor.getCityService()
            } else {
                self?.view?.reloadData(with: self?.coordinates ?? Coordinates(latitude: 55.7522, longitude: 37.6156))
            }
        }
    }
    
    /// Вызывается при нажатии на карточку на карте, открывает экран с детализированной карточкой
    func didTapCell(poster: PosterViewModel) {
        interactor.isInFavorites(poster: poster)
    }
    
}

extension MapPresenter: MapInteractorOutput {
    /// Открывает экран с детализированной информацией о событии, находящемся в избранном у пользователя
    func isInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: true, output: self)
    }
    
    /// Открывает экран с детализированной информацией о событии, не находящемся в избранном у пользователя
    func notInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: false, output: self)
    }
    
    /// Обновляет геоданные и перезагружает интерфейс в соответствии с новыми данными
    func setCityService(cityService: String) {
        self.cityService = cityService
        self.coordinates = ServiceData.shared.getCoordinates(city: cityService)
        self.view?.reloadData(with: coordinates)
    }
    
    /// Показывает ошибку на экране карты
    func didReceive(error: Error) {
        router.showAlertErrorMessage(with: "Неожиданная ошибка")
    }
}

extension MapPresenter: PosterModuleOutput {
    /// Обновляет геоданные из модуля афиши и перезагружает интерфейс в соответствии с новыми данными
    func setNewCity(cityService: String) {
        self.cityService = cityService
        self.coordinates = ServiceData.shared.getCoordinates(city: cityService)
        self.view?.reloadData(with: coordinates)
    }
    
    /// Преобразует данные о местах из модуля афиши в геоданные модуля карты и обновляет их, перезагружает интерфейс
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
