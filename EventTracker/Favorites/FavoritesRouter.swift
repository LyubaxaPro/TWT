import UIKit

final class FavoritesRouter {
    weak var sourceViewController: UIViewController?
    weak var sourceTabBarController: UITabBarController?
}

extension FavoritesRouter: FavoritesRouterInput {
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: FavoritesPresenter) {
        
        let detailContainer = DetailContainer.assemble(with: DetailContext(moduleOutput: output, poster: model, isInFavorites: isInFavorites))
        sourceViewController?.navigationController?.pushViewController(detailContainer.viewController, animated: true)
    }
    
    func showLogin(output: FavoritesPresenter) {
        
        let container = LoginContainer.assemble(with: LoginContext(moduleOutput: output, tabBar: sourceTabBarController ?? UITabBarController()))
        let navigationController = UINavigationController(rootViewController: container.viewController)
        navigationController.modalPresentationStyle = .fullScreen
        sourceViewController?.present(navigationController, animated: true, completion: nil)
    }
    
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }
}
