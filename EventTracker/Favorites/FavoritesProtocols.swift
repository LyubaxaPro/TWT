//
//  FavoritesProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

protocol FavoritesModuleInput {
	var moduleOutput: FavoritesModuleOutput? { get }
}

protocol FavoritesModuleOutput: AnyObject {
}

protocol FavoritesViewInput: AnyObject {
}

protocol FavoritesViewOutput: AnyObject {
}

protocol FavoritesInteractorInput: AnyObject {
}

protocol FavoritesInteractorOutput: AnyObject {
}

protocol FavoritesRouterInput: AnyObject {
}
