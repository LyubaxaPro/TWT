import Foundation

protocol DetailSiteModuleInput {
	var moduleOutput: DetailSiteModuleOutput? { get }
    var urlString: String? { get }
}

protocol DetailSiteModuleOutput: AnyObject {
}

protocol DetailSiteViewInput: AnyObject {
    func loadWebView(with request: URLRequest)
}

protocol DetailSiteViewOutput: AnyObject {
    func viewDidLoad()
    func didTapRefresh()
}

protocol DetailSiteInteractorInput: AnyObject {
}

protocol DetailSiteInteractorOutput: AnyObject {
}

protocol DetailSiteRouterInput: AnyObject {
}
