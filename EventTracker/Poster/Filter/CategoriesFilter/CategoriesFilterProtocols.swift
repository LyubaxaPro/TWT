//
//  CategoriesFilterProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import Foundation

protocol CategoriesFilterModuleInput {
    var moduleOutput: CategoriesFilterModuleOutput? { get }
}

protocol CategoriesFilterModuleOutput: AnyObject {
    func didChangeChosenCategories (chosenCategories: [String : Bool])
}

protocol CategoriesFilterViewInput: AnyObject {
    func reloadTable()
}

protocol CategoriesFilterViewOutput: AnyObject {
    var categories: [String] {get}
    var chosenCategories: [String : Bool] {get}

    func didСhooseCheckmark(with category: String)
    func didСanceledCheckmark(with category: String)

}

protocol CategoriesFilterInteractorInput: AnyObject {
}

protocol CategoriesFilterInteractorOutput: AnyObject {
}

protocol CategoriesFilterRouterInput: AnyObject {
}
