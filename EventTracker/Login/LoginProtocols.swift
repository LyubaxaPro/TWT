//
//  LoginProtocols.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import Foundation

protocol LoginModuleInput {
    var moduleOutput: LoginModuleOutput? { get }
}

protocol LoginModuleOutput: AnyObject {
}

protocol LoginViewInput: AnyObject {
    func showError(description: String)
    func dismiss()
    func backToLoginView()
}

protocol LoginViewOutput: AnyObject {
    func didTapResetPassword(email: String)
    func didReceiveError(description: String)
    func didTapCreateUser(email: String, password: String, name: String, city: String)
    func didTapLogin(login: String, password: String)
    func didTapExitAuth()
    func getCitiesData() -> [String]
}

protocol LoginInteractorInput: AnyObject {
    func createUser(userData: UserData)
    func login(login: String, password: String)
    func resetPassword(email: String)
}

protocol LoginInteractorOutput: AnyObject {
    func didLoad()
    func didReceive(error: String)
    func didResetPassword()
}

protocol LoginRouterInput: AnyObject {
    func showPoster()
}
