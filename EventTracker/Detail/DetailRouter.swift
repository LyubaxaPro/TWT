import UIKit

final class DetailRouter {
    weak var sourceViewController: UIViewController?
}

extension DetailRouter: DetailRouterInput {
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }
    
    func showSite(siteUrl: String, output: DetailPresenter) {
        let context = DetailSiteContext(moduleOutput: output as? DetailSiteModuleOutput, urlString: siteUrl)
        
        let detailSiteContainer = DetailSiteContainer.assemble(with: context )
        sourceViewController?.navigationController?.pushViewController(detailSiteContainer.viewController, animated: true)
    }
}
