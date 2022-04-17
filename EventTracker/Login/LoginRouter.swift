//
//  LoginRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import UIKit

final class LoginRouter {
    weak var sourceTabBarController: UITabBarController?
}

extension LoginRouter: LoginRouterInput {
    func showPoster() {
        self.sourceTabBarController?.selectedIndex = 0
    }

}
