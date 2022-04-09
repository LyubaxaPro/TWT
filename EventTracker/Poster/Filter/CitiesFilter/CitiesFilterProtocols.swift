//
//  CitiesFilterProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//
import Foundation

protocol CitiesFilterModuleInput {
    var moduleOutput: CitiesFilterModuleOutput? { get }
}

protocol CitiesFilterModuleOutput: AnyObject {
    func serviceCity(serviceCity: String, cityName: String)
}

protocol CitiesFilterViewInput: AnyObject {
    func reloadTable()
}

protocol CitiesFilterViewOutput: AnyObject {
    var defaultCities: [String] { get }
    var chosenCity: String { get }
    func didChangeCity (city: String)
}

protocol CitiesFilterInteractorInput: AnyObject {
}

protocol CitiesFilterInteractorOutput: AnyObject {
}

protocol CitiesFilterRouterInput: AnyObject {
}

