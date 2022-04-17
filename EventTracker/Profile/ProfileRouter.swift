//
//  ProfileRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import UIKit

final class ProfileRouter {
    weak var sourceTabBarController: UITabBarController? = UITabBarController()
    weak var sourceViewController: UIViewController?
}

extension ProfileRouter: ProfileRouterInput {
    func showLoginView(output: ProfilePresenter) {

        let container = LoginContainer.assemble(with: LoginContext(moduleOutput: output, tabBar: sourceTabBarController ?? UITabBarController()))
        let navigationController = UINavigationController(rootViewController: container.viewController)
        navigationController.modalPresentationStyle = .fullScreen
        sourceViewController?.present(navigationController, animated: true, completion: nil)
    }

    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }

    func openChangeUserProfile(output: ProfilePresenter, userInfo: UserProfileViewModel) {
        let container = ChangeUserProfileContainer.assemble(with: ChangeUserProfileContext(moduleOutput: output as! ChangeUserProfileModuleOutput, userInfo: userInfo))
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
}
