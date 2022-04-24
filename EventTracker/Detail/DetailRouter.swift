import UIKit

/// Класс, отвечающий за навигацию на экране детализированной информации о событии
final class DetailRouter {
    weak var sourceViewController: UIViewController?
}

extension DetailRouter: DetailRouterInput {
    /// Показывает сообщение об ошибке
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }
    
    /// Показывает сайт события
    func showSite(siteUrl: String, output: DetailPresenter) {
        let context = DetailSiteContext(moduleOutput: output as? DetailSiteModuleOutput, urlString: siteUrl)
        
        let detailSiteContainer = DetailSiteContainer.assemble(with: context )
        sourceViewController?.navigationController?.pushViewController(detailSiteContainer.viewController, animated: true)
    }
}
