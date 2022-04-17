//
//  ProfilePresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation
import Firebase

final class ProfilePresenter {
    weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?
    private (set) var userInfo = UserProfileViewModel(name: "", city: "")

    private let router: ProfileRouterInput
    private let interactor: ProfileInteractorInput

    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor

        Auth.auth().addStateDidChangeListener {[weak self] (auth, user)  in
            if user != nil {
                self?.interactor.getUserInfo()
            }
        }
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    func didTapChange() {
    }

    func didLoadView() {
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user)  in
            if user == nil {
                guard let self = self else {
                    return
                }
            self.router.showLoginView(output: self)
            } else{
                self?.interactor.getUserInfo()
            }
        }
    }

    func didTapLogout() {
        self.interactor.logout()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func setUserInfo(userInfo: UserProfileViewModel) {
        self.userInfo = userInfo
        view?.reloadData()
    }

    func didReceive(error: String) {
        router.showAlertErrorMessage(with: error)
    }

    func showLogin() {
        moduleOutput?.update()
        router.showLoginView(output: self)
    }
}

extension ProfilePresenter: LoginModuleOutput {
}

