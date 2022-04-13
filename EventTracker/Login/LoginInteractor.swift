//
//  LoginInteractor.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import Foundation
import Firebase

final class LoginInteractor {
    weak var output: LoginInteractorOutput?
}

extension LoginInteractor: LoginInteractorInput {
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email){ (error) in
            if error != nil {
                let message: String = "Некорректный email!"
                self.output?.didReceive(error: message)
                return
            }

            self.output?.didResetPassword()
        }
    }

    func login(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) {(result, error) in

            if let error = error {
                var message: String = "Неизвестная ошибка!"
                if (error.localizedDescription == "The email address is badly formatted.") {
                    message = "Некорректный адресс почты!"
                }
                if (error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted.") {
                    message = "Пользователь  не существует!"
                }
                if (error.localizedDescription == "The password is invalid or the user does not have a password.") {
                    message = "Некорректный пароль!"
                }

                self.output?.didReceive(error: message)
                return
            }

            guard result != nil else {
                let message: String = "Неизвестная ошибка!"
                self.output?.didReceive(error: message)
                return
            }

            self.output?.didLoad()
        }
    }

    func createUser(userData: UserData) {
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) {[weak self] (authResult, error) in

            if let error = error {
                var message: String = "Неизвестная ошибка!"
                if (error.localizedDescription == "The email address is badly formatted.") {
                    message = "Некорректный адрес почты!"
                }
                if (error.localizedDescription == "The password must be 6 characters long or more.") {
                    message = "Слабый пароль!"
                }
                self?.output?.didReceive(error: message)
                return
            } else {
                let uid = authResult?.user.uid ?? ""
                if uid.isEmpty {
                    self?.output?.didReceive(error: "Ошибка сети")
                    return
                }

                let ref = Database.database(url: "https://eventtracker-3500c-default-rtdb.firebaseio.com/").reference()
                let userInfo: [String : String] = ["name" : userData.name, "city" : userData.city, "cityService" : userData.cityService]

                ref.child("users/" + uid  + "/userInfo/").setValue(userInfo)
                self?.output?.didLoad()
            }
        }
    }
}

