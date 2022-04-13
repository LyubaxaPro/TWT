//
//  SceneDelegate.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        FirebaseApp.configure()

        let tabBarViewController = UITabBarController()

        let navigationController = UINavigationController(rootViewController: tabBarViewController)
        navigationController.setNavigationBarHidden(true, animated: true)

        let mapContainer = MapContainer.assemble(with: MapContext(moduleOutput: nil))
        let mapViewControllerFromContainer = mapContainer.viewController
        let mapViewController = UINavigationController(rootViewController: mapViewControllerFromContainer)

        let posterContainer = PosterContainer.assemble(with: PosterContext(moduleOutput: mapContainer.presenter))
        let posterViewControllerFromContainer = posterContainer.viewController
        let posterViewController = UINavigationController(rootViewController: posterViewControllerFromContainer)

        let favoritesContainer = FavoritesContainer.assemble(with: tabBarViewController)
        let favoritesViewControllerFromContainer = favoritesContainer.viewController
        let favoritesViewController = UINavigationController(rootViewController: favoritesViewControllerFromContainer)

        let profileContainer = ProfileContainer.assemble(with: ProfileContext(moduleOutput:
                                                        posterContainer.presenter, tabBar: tabBarViewController))

        let profileViewControllerFromContainer = profileContainer.viewController
        let profileViewController = UINavigationController(rootViewController: profileViewControllerFromContainer)


        posterViewController.title = "Афиша"
        favoritesViewController.title = "Избранное"
        mapViewController.title = "Карта"
        profileViewController.title = "Профиль"

        tabBarViewController.setViewControllers([posterViewController, favoritesViewController,
                            mapViewController, profileViewController], animated: false)

        guard let items = tabBarViewController.tabBar.items else {
            return
        }

        let images = ["calendar", "star", "map", "person.crop.circle"]
        for temp in 0..<items.count {
            items[temp].image = UIImage(systemName: images[temp])
        }

        window.rootViewController = navigationController

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
