//
//  ChangeUserProfileProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//

import Foundation

protocol ChangeUserProfileModuleInput {
    var moduleOutput: ChangeUserProfileModuleOutput? { get }
}

protocol ChangeUserProfileModuleOutput: AnyObject {
    func didChangeCity()
}

protocol ChangeUserProfileViewInput: AnyObject {
}

protocol ChangeUserProfileViewOutput: AnyObject {
    func getName() -> String
    func getCity() -> String
    func getCitiesData() -> [String]
    func getCityIndex() -> Int
    func didTapChangeUserProfile(newCity: String, newName: String)
}

protocol ChangeUserProfileInteractorInput: AnyObject {
    func changeUserData(userData: UserProfileViewModel)
}

protocol ChangeUserProfileInteractorOutput: AnyObject {
    func didReceive(error: String)
    func didChangeData()
}

protocol ChangeUserProfileRouterInput: AnyObject {
    func showAlertErrorMessage(with message: String)
    func backToProfile()
}

