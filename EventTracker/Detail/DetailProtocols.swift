import Foundation

protocol DetailModuleInput {
	var moduleOutput: DetailModuleOutput? { get }
    var poster: PosterViewModel? { get }
}

protocol DetailModuleOutput: AnyObject {
}

protocol DetailViewInput: AnyObject {
    func loadData(with model: DetailViewModel)
}

protocol DetailViewOutput: AnyObject {
    func didLoadView()
    func didTapButtonUrl()
    func didTapAddToFavorites()
    func didTapRemoveFromFavorites()
}

protocol DetailInteractorInput: AnyObject {
    func addToFavorites(dict: [String : Any])
    func removeFromFavorites(id: Int?)
}

protocol DetailInteractorOutput: AnyObject {
    func didReceive(message: String)
}

protocol DetailRouterInput: AnyObject {
    func showSite(siteUrl: String, output: DetailPresenter)
    func showAlertErrorMessage(with message: String)
}
