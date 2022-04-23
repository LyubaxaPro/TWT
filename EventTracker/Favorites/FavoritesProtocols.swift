import Foundation

protocol FavoritesViewInput: AnyObject {
    func reloadData()
}

protocol FavoritesViewOutput: AnyObject  {
    var postersViewModels: [PosterViewModel] { get }
    
    func didLoadView()
    func didPullRefresh()
    func didTapCell(poster: PosterViewModel)
}

protocol FavoritesInteractorInput: AnyObject {
    func load()
}

protocol FavoritesInteractorOutput: AnyObject {
    func didLoad(posters: [PosterViewModel])
    func didReceive(error: Error)
}

protocol FavoritesRouterInput: AnyObject {
    func showLogin(output: FavoritesPresenter)
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: FavoritesPresenter)
    func showAlertErrorMessage(with: String)
}
