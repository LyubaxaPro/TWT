import Foundation
import Firebase

final class PosterPresenter {
    weak var moduleOutput: PosterModuleOutput?
	weak var view: PosterViewInput?
	private let router: PosterRouterInput
	private let interactor: PosterInteractorInput
    
    private var serviceInfos: PosterServiceInfo = PosterServiceInfo(location:"msk", category: [])
    
    init(router: PosterRouterInput, interactor: PosterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private (set) var postersViewModels: [PosterViewModel] = []
    var searchPostersViewModels: [PosterViewModel] = []
    
}

extension PosterPresenter: PosterModuleInput {
    
}

extension PosterPresenter: PosterViewOutput {
    
    func didLoadView() {
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user)  in
            if user != nil {
                self?.interactor.getCityService()
            } else {
                self?.interactor.load(posters: self?.serviceInfos ?? PosterServiceInfo(location: "msk", category: []))
                self?.moduleOutput?.setNewCity(cityService: "msk")
            }
        }
    }
    
    func didPullRefresh() {
        interactor.load(posters: serviceInfos)
    }
    
    func didTapCell(poster: PosterViewModel) {
        interactor.isInFavorites(poster: poster)
    }
    
    func didTapFilter() {
        router.openFilter(output: self, defaultCityService: serviceInfos.location)
    }
}

extension PosterPresenter: PosterInteractorOutput {
    func setCityService(cityService: String) {
        self.serviceInfos.location = cityService
        interactor.load(posters: self.serviceInfos)
        moduleOutput?.setNewCity(cityService: cityService)
    }
    
    func isInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: true, output: self)
    }
    
    func notInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: false, output: self)
    }
    
    func didLoad(posters: [PosterResults]) {
        
        let postersViewModels = posters.map { poster in

            return PosterViewModelManager.shared.posterResultsToPosterViewModel(poster: poster)
        }
        self.postersViewModels = postersViewModels
        self.view?.reloadData()
        moduleOutput?.setNewPosters(posters: posters)
    }
    
    func didReceive(error: Error) {
        router.showAlertErrorMessage(with: "Неожиданная ошибка")
    }
}

extension PosterPresenter: DetailModuleOutput {
}

extension PosterPresenter: FilterModuleOutput {
    func setFilterValues(filterValues: FilterValues) {
        interactor.load(posters: PosterServiceInfo(location: filterValues.location, category: filterValues.categories))
        moduleOutput?.setNewCity(cityService: filterValues.location)
        view?.startRefreshing()
    }
}

extension PosterPresenter: UserProfileModuleOutput {
    func update() {
        self.serviceInfos = PosterServiceInfo(location:"msk", category: [])
        didLoadView()
        router.clearViewStack()
    }
}
