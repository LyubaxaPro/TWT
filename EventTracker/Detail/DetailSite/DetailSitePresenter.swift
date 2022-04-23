import Foundation

final class DetailSitePresenter {
	weak var view: DetailSiteViewInput?
    weak var moduleOutput: DetailSiteModuleOutput?
    var urlString: String?

	private let router: DetailSiteRouterInput
	private let interactor: DetailSiteInteractorInput

    init(router: DetailSiteRouterInput, interactor: DetailSiteInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DetailSitePresenter: DetailSiteModuleInput {
}

extension DetailSitePresenter: DetailSiteViewOutput {
    func viewDidLoad() {
        guard let url = URL(string: urlString ?? "") else {
            return
        }
        
        let myRequest = URLRequest(url: url)
        view?.loadWebView(with: myRequest)
    }
    
    func didTapRefresh() {
        viewDidLoad()
    }
}

extension DetailSitePresenter: DetailSiteInteractorOutput {
}
