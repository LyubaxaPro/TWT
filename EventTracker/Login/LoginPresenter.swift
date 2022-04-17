//
//  LoginPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import Foundation

final class LoginPresenter {
    weak var view: LoginViewInput?
    weak var moduleOutput: LoginModuleOutput?

    private let router: LoginRouterInput
    private let interactor: LoginInteractorInput

    init(router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginModuleInput {
}

extension LoginPresenter: LoginViewOutput {
    func didTapResetPassword(email: String) {
        interactor.resetPassword(email: email)
    }

    func didReceiveError(description: String) {
        view?.showError(description: description)
    }

    func didTapCreateUser(email: String, password: String, name: String, city: String) {
        let userData = UserData(email: email, password: password, name: name, city: city, cityService: ServiceData.shared.getCities()[city] ?? "msk")
        self.interactor.createUser(userData: userData)
    }

    func didTapLogin(login: String, password: String) {
        self.interactor.login(login: login, password: password)
    }

    func didTapExitAuth() {
        self.router.showPoster()
        view?.dismiss()
    }

    func getCitiesData() -> [String] {
        return ServiceData.shared.getCities().keys.sorted()
    }

}

extension LoginPresenter: LoginInteractorOutput {
    func didLoad() {
        self.view?.dismiss()
    }

    func didReceive(error: String) {
        view?.showError(description: error)
    }

    func didResetPassword() {
        self.view?.backToLoginView()
    }
}
