//
//  ChangeUserProfileInteractor.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//

import Foundation

/// Класс, отвечающий за бизнес-логику редактора профиля
final class ChangeUserProfileInteractor {
    weak var output: ChangeUserProfileInteractorOutput?
}

extension ChangeUserProfileInteractor: ChangeUserProfileInteractorInput {
    /// Обновляет данные о пользователе
    func changeUserData(userData: UserProfileViewModel) {
        UserProfileManager.shared.changeUserData(userData: userData) {[weak self] result in
            switch (result) {
            case false:
                self?.output?.didReceive(error: "Неожиданная ошибка")
            case true:
                self?.output?.didChangeData()
            }
        }
    }
}

