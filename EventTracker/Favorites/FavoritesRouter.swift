import UIKit

/// Класс, отвечающий за навигацию на экране избранного
final class FavoritesRouter {
    weak var sourceViewController: UIViewController?
    weak var sourceTabBarController: UITabBarController?
}

extension FavoritesRouter: FavoritesRouterInput {
    /// Открывает эктан с детализированной информацией о событии
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: FavoritesPresenter) {
        
        let detailContainer = DetailContainer.assemble(with: DetailContext(moduleOutput: output, poster: model, isInFavorites: isInFavorites))
        sourceViewController?.navigationController?.pushViewController(detailContainer.viewController, animated: true)
    }
    
    /// Открывает экран авторизации
    func showLogin(output: FavoritesPresenter) {
        
        let container = LoginContainer.assemble(with: LoginContext(moduleOutput: output, tabBar: sourceTabBarController ?? UITabBarController()))
        let navigationController = UINavigationController(rootViewController: container.viewController)
        navigationController.modalPresentationStyle = .fullScreen
        sourceViewController?.present(navigationController, animated: true, completion: nil)
    }
    
    /// Показывает ошибку на экране избранного
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }
}
