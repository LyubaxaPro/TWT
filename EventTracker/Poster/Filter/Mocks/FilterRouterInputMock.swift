//
//  FilterRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class FilterRouterInputMock: FilterRouterInput {
    func showCitiesFilter(output: FilterPresenter, city: String) {
    }

    func showCategoriesFilter(output: FilterPresenter, categories: [String : Bool]) {
    }

    func closeFilter() {
    }
}
