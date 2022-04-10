import UIKit

final class PosterContainer {
	let viewController: UIViewController
    let presenter: PosterPresenter
    
    private init(viewController: UIViewController, presenter: PosterPresenter) {
        self.viewController = viewController
        self.presenter = presenter
    }

    class func assemble(with context: PosterContext) -> PosterContainer {
        let router = PosterRouter()
        let interactor = PosterInteractor()
        let presenter = PosterPresenter(router: router, interactor: interactor)
		let viewController = PosterViewController(output: presenter)
        presenter.moduleOutput = context.moduleOutput

        router.sourceViewController = viewController
		presenter.view = viewController
		interactor.output = presenter

        return PosterContainer(viewController: viewController, presenter: presenter)
	}
}

struct PosterContext {
    weak var moduleOutput: PosterModuleOutput?
}

