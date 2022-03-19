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

protocol FavoritesModuleOutput: class {
}

protocol FavoritesViewInput: class {
}

protocol FavoritesViewOutput: class {
}

protocol FavoritesInteractorInput: class {
}

protocol FavoritesInteractorOutput: class {
}

protocol FavoritesRouterInput: class {
}
