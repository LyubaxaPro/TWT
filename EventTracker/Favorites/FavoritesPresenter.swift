import Foundation
import Firebase

/// Класс, отвечающий за бизнес логику и представление экрана избранного
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
    /// Вызывается при загрузке экрана избранного, загружает данные об избранном для авторизованного пользователя и открывает экран авторизации для неавтооризованного
    func didLoadView() {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            if user != nil {
                self.interactor.load()
            } else {
                self.router.showLogin(output: self)
            }
        }
    }
    
    /// Перезагружает данные об избранном
    func didPullRefresh() {
        interactor.load()
    }
    
    /// Вызывается при нажатии на карточку события, передает управление классу, отвечающему за навигацию, для открытия экрана события
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
