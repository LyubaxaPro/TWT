//
//  ChangeUserProfileInteractor.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//

import Foundation

final class ChangeUserProfileInteractor {
    weak var output: ChangeUserProfileInteractorOutput?
}

extension ChangeUserProfileInteractor: ChangeUserProfileInteractorInput {
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

