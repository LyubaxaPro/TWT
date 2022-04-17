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

	private let router: ProfileRouterInput
	private let interactor: ProfileInteractorInput

    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    func didLoadView() {
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user)  in
            if user == nil {
                guard let self = self else {
                    return
                }
            self.router.showLoginView(output: self)
            } else{
//                self?.interactor.getUserInfo()
            }
        }
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func showLogin() {
 //       moduleOutput?.update()
        router.showLoginView(output: self)
    }
}

extension ProfilePresenter: LoginModuleOutput {
}
