import UIKit

final class DetailSiteContainer {
    let input: DetailSiteModuleInput
	let viewController: UIViewController
	private(set) weak var router: DetailSiteRouterInput!

	class func assemble(with context: DetailSiteContext) -> DetailSiteContainer {
        let router = DetailSiteRouter()
        let interactor = DetailSiteInteractor()
        let presenter = DetailSitePresenter(router: router, interactor: interactor)
		let viewController = DetailSiteViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.urlString = context.urlString

		interactor.output = presenter

        return DetailSiteContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: DetailSiteModuleInput, router: DetailSiteRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct DetailSiteContext {
	weak var moduleOutput: DetailSiteModuleOutput?
    var urlString: String
}
