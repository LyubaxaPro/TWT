//
//  ProfileProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation

protocol ProfileModuleInput {
	var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: class {
}

protocol ProfileViewInput: class {
}

protocol ProfileViewOutput: class {
}

protocol ProfileInteractorInput: class {
}

protocol ProfileInteractorOutput: class {
}

protocol ProfileRouterInput: class {
}
