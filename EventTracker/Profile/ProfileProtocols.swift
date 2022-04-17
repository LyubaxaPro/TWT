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

protocol ProfileModuleOutput: AnyObject {
    func update()
}

protocol ProfileViewInput: AnyObject {
    func reloadData()
}

protocol ProfileViewOutput: AnyObject {
    var userInfo: UserProfileViewModel { get }
    func didLoadView()
    func didTapLogout()
    func didTapChange()
}

protocol ProfileInteractorInput: AnyObject {
    func logout()
    func getUserInfo()
}

protocol ProfileInteractorOutput: AnyObject {
    func didReceive(error: String)
    func setUserInfo(userInfo: UserProfileViewModel)
    func showLogin()
}

protocol ProfileRouterInput: AnyObject {
    func showLoginView(output: ProfilePresenter)
    func showAlertErrorMessage(with message: String)
}
