//
//  ChangeUserProfileContainer.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//

import UIKit

/// Класс, отвечающий за создание модуля экрана редактора профиля
final class ChangeUserProfileContainer {
    let input: ChangeUserProfileModuleInput
    let viewController: UIViewController
    private(set) weak var router: ChangeUserProfileRouterInput!

    /// Создает модуль экрана редактора профиля
    class func assemble(with context: ChangeUserProfileContext) -> ChangeUserProfileContainer {
        let router = ChangeUserProfileRouter()
        let interactor = ChangeUserProfileInteractor()
        let presenter = ChangeUserProfilePresenter(router: router, interactor: interactor)
        let viewController = ChangeUserProfileViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter
        presenter.userInfo = context.userInfo
        router.sourceViewController = viewController

        return ChangeUserProfileContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: ChangeUserProfileModuleInput, router: ChangeUserProfileRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ChangeUserProfileContext {
    weak var moduleOutput: ChangeUserProfileModuleOutput?
    var userInfo: UserProfileViewModel
}
