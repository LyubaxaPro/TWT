//
//  LoginPresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import Foundation

/// Управляющий класс модуля экрана авторизации
final class LoginPresenter {
    weak var view: LoginViewInput?
    weak var moduleOutput: LoginModuleOutput?

    private let router: LoginRouterInput
    private let interactor: LoginInteractorInput

    /// Инициализация
    init(router: LoginRouterInput, interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginModuleInput {
}

/// Получение информации от вью
extension LoginPresenter: LoginViewOutput {
    /// Нажата кнопка сброса пароля
    func didTapResetPassword(email: String) {
        interactor.resetPassword(email: email)
    }

    /// Отобразить ошибку
    func didReceiveError(description: String) {
        view?.showError(description: description)
    }

    /// Нажата кнопка создания нового пользователя
    func didTapCreateUser(email: String, password: String, name: String, city: String) {
        let userData = UserData(email: email, password: password, name: name, city: city, cityService: ServiceData.shared.getCities()[city] ?? "msk")
        self.interactor.createUser(userData: userData)
    }

    /// Нажата кнопка входа
    func didTapLogin(login: String, password: String) {
        self.interactor.login(login: login, password: password)
    }

    /// Нажата кнопка авторизации
    func didTapExitAuth() {
        self.router.showPoster()
        view?.dismiss()
    }

    /// Получить данные города пользователя
    func getCitiesData() -> [String] {
        return ServiceData.shared.getCities().keys.sorted()
    }

}

/// Получение информации от базы данных
extension LoginPresenter: LoginInteractorOutput {
    /// Вход произведен успешно, можно закрыть модальное окно
    func didLoad() {
        self.view?.dismiss()
    }

    /// Обработка ошибки
    func didReceive(error: String) {
        view?.showError(description: error)
    }

    /// Восстановление пароля прошло успешно, необходимо ввести новый пароль
    func didResetPassword() {
        self.view?.backToLoginView()
    }
}
