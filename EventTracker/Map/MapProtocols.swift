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

protocol MapModuleOutput: AnyObject {
}

protocol MapViewInput: AnyObject {
}

protocol MapViewOutput: AnyObject {
}

protocol MapInteractorInput: AnyObject {
}

protocol MapInteractorOutput: AnyObject {
}

protocol MapRouterInput: AnyObject {
}
