import UIKit

final class PosterRouter {
    weak var sourceViewController: UIViewController?
}

extension PosterRouter: PosterRouterInput {
    func openFilter(output: PosterPresenter, defaultCityService: String) {
        let filterContainer = FilterContainer.assemble(with: FilterContext(moduleOutput: output, cityService: defaultCityService))
        sourceViewController?.navigationController?.pushViewController(filterContainer.viewController, animated: true)
    }
    
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: PosterPresenter) {
        let detailContainer = DetailContainer.assemble(with: DetailContext(moduleOutput: output, poster: model, isInFavorites: isInFavorites))
        sourceViewController?.navigationController?.pushViewController(detailContainer.viewController, animated: true)
    }
    
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }
    
    func clearViewStack() {
        sourceViewController?.navigationController?.popToRootViewController(animated: false)
    }
}

