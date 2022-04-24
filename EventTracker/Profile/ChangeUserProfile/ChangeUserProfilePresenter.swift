//
//  ChangeUserProfilePresenter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//

import Foundation

/// Класс, отвечающий за управление бизнес-логикой и представлением редактора профиля
final class ChangeUserProfilePresenter {
    weak var view: ChangeUserProfileViewInput?
    weak var moduleOutput: ChangeUserProfileModuleOutput?

    private let router: ChangeUserProfileRouterInput
    private let interactor: ChangeUserProfileInteractorInput
    var userInfo = UserProfileViewModel(name: "", city: "")

    init(router: ChangeUserProfileRouterInput, interactor: ChangeUserProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ChangeUserProfilePresenter: ChangeUserProfileModuleInput {
}

extension ChangeUserProfilePresenter: ChangeUserProfileViewOutput {
    /// Вызывается при обновлении данных о пользователе, передает управление бизнес-логик
    func didTapChangeUserProfile(newCity: String, newName: String) {
        interactor.changeUserData(userData: UserProfileViewModel(name: newName, city: newCity))
    }

    func getName() -> String {
        return userInfo.name
    }

    func getCity() -> String {
        return userInfo.city
    }

    func getCitiesData() -> [String] {
        return ServiceData.shared.getCities().keys.sorted()
    }

    func getCityIndex() -> Int {
        return ServiceData.shared.getCities().keys.sorted().firstIndex{$0 == userInfo.city} ?? 0
    }
}

extension ChangeUserProfilePresenter: ChangeUserProfileInteractorOutput {
    /// Вызывается  в случае ошибки, передает управление классу навигации
    func didReceive(error: String) {
        router.showAlertErrorMessage(with: error)
    }

    /// Вызывается после изменения данных о пользователе
    func didChangeData() {
        moduleOutput?.didChangeCity()
        router.backToProfile()
    }
}
