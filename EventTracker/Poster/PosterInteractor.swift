import Foundation

final class PosterInteractor {
	weak var output: PosterInteractorOutput?
    
    private let postersManager: PostersManagerDescription = PostersManager.shared
}

extension PosterInteractor: PosterInteractorInput {
    func load(posters: PosterServiceInfo) {
        postersManager.load(posters: posters) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posters):
                    self?.output?.didLoad(posters: posters)
                case .failure(let error):
                    self?.output?.didReceive(error: error)
                }
            }
        }
    }
    
    func isInFavorites(poster: PosterViewModel) {
        DetailManager.shared.isInFavorites(id: poster.id) { [weak self] (flag) in
            if flag {
                self?.output?.isInFavorites(poster: poster)
            } else {
                self?.output?.notInFavorites(poster: poster)
            }
        }
    }
    
    func getCityService() {
        UserProfileManager.shared.getCityService { [weak self] result in
            switch(result) {
            case .success(let cityService):
                self?.output?.setCityService(cityService: cityService)
            case .failure(let error):
                self?.output?.didReceive(error: error)
            }
        }
    }
}
