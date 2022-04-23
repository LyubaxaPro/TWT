import Foundation
import Firebase

final class FavoritesPresenter {
	weak var view: FavoritesViewInput?

	private let router: FavoritesRouterInput
	private let interactor: FavoritesInteractorInput
    
    
    init(router: FavoritesRouterInput, interactor: FavoritesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private (set) var postersViewModels: [PosterViewModel] = []
}

extension FavoritesPresenter: FavoritesViewOutput {
    
    func didLoadView() {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            if user != nil {
                self.interactor.load()
            } else {
                self.router.showLogin(output: self)
            }
        }
    }
    
    func didPullRefresh() {
        interactor.load()
    }
    
    func didTapCell(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: true, output: self)
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput {
    func didLoad(posters: [PosterViewModel]) {
        self.postersViewModels = posters
        self.postersViewModels.sort {(lhs: PosterViewModel, rhs: PosterViewModel) -> Bool in
            return lhs.title < rhs.title
        }
        view?.reloadData()
    }
    
    func didReceive(error: Error) {
        router.showAlertErrorMessage(with: "Неожиданная ошибка")
    }
}

extension FavoritesPresenter: DetailModuleOutput {
}

extension FavoritesPresenter: LoginModuleOutput{
    
}
