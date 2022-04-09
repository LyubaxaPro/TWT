//
//  FilterProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import Foundation

protocol FilterModuleInput {
    var moduleOutput: FilterModuleOutput? { get }
}

protocol FilterModuleOutput: AnyObject {
    func setFilterValues(filterValues: FilterValues)
}

protocol FilterViewInput: AnyObject {
    func update()
}

protocol FilterViewOutput: AnyObject {
    func didTapCell(with title: String)
    func didTapAcceptButton()
    func getCity() -> String
    func getCategoriesIndicator() -> String
}

protocol FilterInteractorInput: AnyObject {
}

protocol FilterInteractorOutput: AnyObject {
}

protocol FilterRouterInput: AnyObject {
    func closeFilter()
    func showCitiesFilter(output: FilterPresenter, city: String)
}
