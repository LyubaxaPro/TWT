import Foundation

/// Управляющий класс в модуле экрана афиши
final class PosterPresenter {
    /// Получение информации из класса другими классами
    weak var moduleOutput: PosterModuleOutput?
    /// Вью, для отображения на карточке
    weak var view: PosterViewInput?
    /// Управление навигацией
    private let router: PosterRouterInput
    /// Работа с базой данных
    private let interactor: PosterInteractorInput

    /// Информация о городе и категориях для составления URL и запроса в API
    private var serviceInfos: PosterServiceInfo = PosterServiceInfo(location:"msk", category: [])

    /// Инициализация
    init(router: PosterRouterInput, interactor: PosterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }

    /// Список моделей для отображения  в карточках
    private (set) var postersViewModels: [PosterViewModel] = []
    /// Список моделей по результатам поиска
    var searchPostersViewModels: [PosterViewModel] = []

}

extension PosterPresenter: PosterModuleInput {

}

/// Получение информации от вью модели
extension PosterPresenter: PosterViewOutput {

    /// Загрузка вью
    func didLoadView() {
        interactor.load(posters: self.serviceInfos ?? PosterServiceInfo(location: "msk", category: []))
        moduleOutput?.setNewCity(cityService: "msk")
    }

    /// Обновить афишу
    func didPullRefresh() {
        interactor.load(posters: serviceInfos)
    }

    /// Нажатие на ячейку
    func didTapCell(poster: PosterViewModel) {
        interactor.isInFavorites(poster: poster)
    }

    /// Нажатие на фильтр
    func didTapFilter() {
        router.openFilter(output: self, defaultCityService: serviceInfos.location)
    }
}

/// Получение информации из PosterInteractorOutput
extension PosterPresenter: PosterInteractorOutput {
    /// Установить информацию для похода в сеть
    func setCityService(cityService: String) {
        self.serviceInfos.location = cityService
        interactor.load(posters: self.serviceInfos)
        moduleOutput?.setNewCity(cityService: cityService)
    }

    /// Отображение события если оно в избранных
    func isInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: true, output: self)
    }

    /// Отображение события если оно не в избранных
    func notInFavorites(poster: PosterViewModel) {
        router.showPoster(with: poster, isInFavorites: false, output: self)
    }

    /// Загрузка афиши
    func didLoad(posters: [PosterResults]) {

        let postersViewModels = posters.map { poster in

            return PosterViewModelManager.shared.posterResultsToPosterViewModel(poster: poster)
        }
        self.postersViewModels = postersViewModels
        self.view?.reloadData()
        moduleOutput?.setNewPosters(posters: posters)
    }

    /// Обработка ошибки
    func didReceive(error: Error) {
        router.showAlertErrorMessage(with: "Неожиданная ошибка")
    }
}

/// Получение информации из модуля профиля
extension PosterPresenter: ProfileModuleOutput {
    /// Обновление информации о городе и категориях
    func update() {
        self.serviceInfos = PosterServiceInfo(location:"msk", category: [])
        didLoadView()
        router.clearViewStack()
    }
}

/// Получение информации из модуля фильтрации
extension PosterPresenter: FilterModuleOutput {
    /// Обновление афиши по фильтрам
    func setFilterValues(filterValues: FilterValues) {
        interactor.load(posters: PosterServiceInfo(location: filterValues.location, category: filterValues.categories))
        moduleOutput?.setNewCity(cityService: filterValues.location)
        view?.startRefreshing()
    }
}

/// Получение информации из модуля детализированной карточки события
extension PosterPresenter: DetailModuleOutput {
}

