import UIKit

/// Класс, отвечающий за создание модуля детализированной информации о событии
final class DetailContainer {
    let input: DetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: DetailRouterInput!

    /// Создает модуль экрана детализированной информации о событии
	class func assemble(with context: DetailContext) -> DetailContainer {
        let router = DetailRouter()
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(router: router, interactor: interactor)
		let viewController = DetailViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter
        presenter.moduleOutput = context.moduleOutput
        presenter.poster = context.poster
        presenter.isInFavorites = context.isInFavorites
        router.sourceViewController = viewController
        
        return DetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: DetailModuleInput, router: DetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct DetailContext {
	weak var moduleOutput: DetailModuleOutput?
    var poster: PosterViewModel
    var isInFavorites: Bool
}
