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

protocol PosterModuleOutput: class {
}

protocol PosterViewInput: class {
}

protocol PosterViewOutput: class {
}

protocol PosterInteractorInput: class {
}

protocol PosterInteractorOutput: class {
}

protocol PosterRouterInput: class {
}
