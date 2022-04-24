import UIKit

/// Управление навигацией
final class PosterRouter {
    weak var sourceViewController: UIViewController?
}

/// Получение информации от управляющего элемента
extension PosterRouter: PosterRouterInput {
    /// Открыть жкран фильтра
    func openFilter(output: PosterPresenter, defaultCityService: String) {
        let filterContainer = FilterContainer.assemble(with: FilterContext(moduleOutput: output, cityService: defaultCityService))
        sourceViewController?.navigationController?.pushViewController(filterContainer.viewController, animated: true)
    }

    /// Открыть детализированную карточку события
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: PosterPresenter) {
        let detailContainer = DetailContainer.assemble(with: DetailContext(moduleOutput: output, poster: model, isInFavorites: isInFavorites))
        sourceViewController?.navigationController?.pushViewController(detailContainer.viewController, animated: true)
    }

    /// Показать сообщение об ошибке
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }

    /// Очистить стек экранов
    func clearViewStack() {
        sourceViewController?.navigationController?.popToRootViewController(animated: false)
    }
}

