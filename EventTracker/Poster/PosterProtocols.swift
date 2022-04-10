import Foundation

protocol PosterModuleInput {
    var moduleOutput: PosterModuleOutput? { get }
}

protocol PosterModuleOutput: AnyObject {
    func setNewPosters(posters: [PosterResults])
    func setNewCity(cityService: String)
}

protocol PosterViewInput: AnyObject {
    func reloadData()
    func startRefreshing()
}

protocol PosterViewOutput: AnyObject {
    
    var postersViewModels: [PosterViewModel] { get }
    var searchPostersViewModels: [PosterViewModel] { get set }
    
    func didLoadView()
    func didPullRefresh()
    func didTapCell(poster: PosterViewModel)
    func didTapFilter()
}

protocol PosterInteractorInput: AnyObject {
    func load(posters: PosterServiceInfo)
    func isInFavorites(poster: PosterViewModel)
    func getCityService()
}

protocol PosterInteractorOutput: AnyObject {
    func didLoad(posters: [PosterResults])
    func didReceive(error: Error)
    func isInFavorites(poster: PosterViewModel)
    func notInFavorites(poster: PosterViewModel)
    func setCityService(cityService: String)
}

protocol PosterRouterInput: AnyObject {
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: PosterPresenter)
    func openFilter(output: PosterPresenter, defaultCityService: String)
    func showAlertErrorMessage(with: String)
    func clearViewStack()
}
