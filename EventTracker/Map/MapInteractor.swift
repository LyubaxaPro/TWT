//
//  MapInteractor.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

final class MapInteractor {
	weak var output: MapInteractorOutput?
}

/// Класс с бизнес-логикой экрана 
extension MapInteractor: MapInteractorInput {
    /// Предоставляет данные о городе пользоователя
    func getCityService() {
        UserProfileManager.shared.getCityService { [weak self] result in
            switch(result) {
            case .success(let cityService):
                self?.output?.setCityService(cityService: cityService)
            case .failure(let error):
                self?.output?.didReceive(error: error)
            }
        }
    }
    
    /// Предоставляет данные о том, находится ли событие в избранном
    func isInFavorites(poster: PosterViewModel) {
        DetailManager.shared.isInFavorites(id: poster.id) { [weak self] (flag) in
            if flag {
                self?.output?.isInFavorites(poster: poster)
            } else {
                self?.output?.notInFavorites(poster: poster)
            }
        }
    }
}
