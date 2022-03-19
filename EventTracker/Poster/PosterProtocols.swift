//
//  PosterProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

protocol PosterModuleInput {
	var moduleOutput: PosterModuleOutput? { get }
}

protocol PosterModuleOutput: AnyObject {
}

protocol PosterViewInput: AnyObject {
}

protocol PosterViewOutput: AnyObject {
}

protocol PosterInteractorInput: AnyObject {
}

protocol PosterInteractorOutput: AnyObject {
}

protocol PosterRouterInput: AnyObject {
}
