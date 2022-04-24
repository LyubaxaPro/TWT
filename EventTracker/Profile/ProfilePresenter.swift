//
//  ProfilePresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation
import Firebase

/// Класс, отвечающий за управление представлением и бизнес-логикой в модуле профиля
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
    /// Вызывается при необходимости изменить данные о профиле пользователя, передает управление классу, отвечающему за навигацию модуля профиля
    func didTapChange() {
        router.openChangeUserProfile(output: self, userInfo: userInfo)
    }

    /// Загружает данные о профиле пользователя
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

    /// Вызывается при выходе пользователя из профиля, передает управление бизнес-логике
    func didTapLogout() {
        self.interactor.logout()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    /// Обновляет данные о пользователе
    func setUserInfo(userInfo: UserProfileViewModel) {
        self.userInfo = userInfo
        view?.reloadData()
    }

    /// Показывает ошибку на экране профиля
    func didReceive(error: String) {
        router.showAlertErrorMessage(with: error)
    }

    /// Показывает экран авторизации
    func showLogin() {
        moduleOutput?.update()
        router.showLoginView(output: self)
    }
}

extension ProfilePresenter: LoginModuleOutput {
}

extension ProfilePresenter: ChangeUserProfileModuleOutput {
    /// Обновляет данные о городе пользователя
    func didChangeCity() {
        moduleOutput?.update()
    }
}
