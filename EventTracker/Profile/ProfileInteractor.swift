//
//  ProfileInteractor.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import Foundation
import Firebase

final class ProfileInteractor {
    weak var output: ProfileInteractorOutput?
}

extension ProfileInteractor: ProfileInteractorInput {
    func logout() {
        do {
            try Auth.auth().signOut()
            self.output?.showLogin()
        } catch {
            let message: String = "Неизвестная ошибка!"
            self.output?.didReceive(error: message)
        }
    }

    func getUserInfo() {
        UserProfileManager.shared.getUserInfo { [weak self] result in
            switch(result) {
            case .failure(let error):
                let message: String = "Неизвестная ошибка!"
                self?.output?.didReceive(error: message)

            case .success(let userInfo):
                self?.output?.setUserInfo(userInfo: userInfo)
            }
        }
    }
}
