//
//  LoginRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import UIKit
/// Навигация модуля авторизации приложения
final class LoginRouter {
    weak var sourceTabBarController: UITabBarController?
}

extension LoginRouter: LoginRouterInput {
    /// Показать мероприятие
    func showPoster() {
        self.sourceTabBarController?.selectedIndex = 0
    }

}
