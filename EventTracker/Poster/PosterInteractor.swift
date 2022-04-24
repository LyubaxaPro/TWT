import Foundation

/// Работа с базой данных для модуля экрана афиши
final class PosterInteractor {
    /// Вывод данных из модуля
	weak var output: PosterInteractorOutput?
    private let postersManager: PostersManagerDescription = PostersManager.shared
}

/// Отдать данные управляющему классу модуля (presenter)
extension PosterInteractor: PosterInteractorInput {
    /// Загрузить новые события
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

    /// Проверить находится изображение в избранных или нет
    func isInFavorites(poster: PosterViewModel) {
        DetailManager.shared.isInFavorites(id: poster.id) { [weak self] (flag) in
            if flag {
                self?.output?.isInFavorites(poster: poster)
            } else {
                self?.output?.notInFavorites(poster: poster)
            }
        }
    }

    /// Получить информацию о городе
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
