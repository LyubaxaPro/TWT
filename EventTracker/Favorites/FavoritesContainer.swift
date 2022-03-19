//
//  FavoritesContainer.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import UIKit

final class FavoritesContainer {
    let viewController: UIViewController

    private init(view: UIViewController) {
        self.viewController = view
    }

    class func assemble(with: UITabBarController) -> FavoritesContainer {
        let router = FavoritesRouter()
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter(router: router, interactor: interactor)
        let viewController = FavoritesViewController(output: presenter)

        presenter.view = viewController
        interactor.output = presenter

        return FavoritesContainer(view: viewController)
    }
}
