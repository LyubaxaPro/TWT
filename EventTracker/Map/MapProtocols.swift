//
//  MapProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

protocol MapModuleInput {
	var moduleOutput: MapModuleOutput? { get }
}

protocol MapModuleOutput: class {
}

protocol MapViewInput: class {
}

protocol MapViewOutput: class {
}

protocol MapInteractorInput: class {
}

protocol MapInteractorOutput: class {
}

protocol MapRouterInput: class {
}
