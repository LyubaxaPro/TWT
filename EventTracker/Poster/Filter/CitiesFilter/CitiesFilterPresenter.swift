//
//  CitiesFilterPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//
import Foundation

final class CitiesFilterPresenter {
    weak var view: CitiesFilterViewInput?
    weak var moduleOutput: CitiesFilterModuleOutput?

    private (set) var defaultCities: [String] = []
    private (set) var chosenCity: String = ""

    private let router: CitiesFilterRouterInput
    private let interactor: CitiesFilterInteractorInput

    init(router: CitiesFilterRouterInput, interactor: CitiesFilterInteractorInput, previousCity: String) {
        self.router = router
        self.interactor = interactor
        defaultCities = Array(ServiceData.shared.getCities().keys).sorted()
        chosenCity = previousCity
    }
}

extension CitiesFilterPresenter: CitiesFilterModuleInput {
}

extension CitiesFilterPresenter: CitiesFilterViewOutput {
    func didChangeCity(city: String) {
        if chosenCity != city {
            chosenCity = city
            view?.reloadTable()
        }
        moduleOutput?.serviceCity(serviceCity: ServiceData.shared.getCities()[city] ?? "msk", cityName: city)
    }
}

extension CitiesFilterPresenter: CitiesFilterInteractorOutput {
}

