import Foundation

/// Класс, отвечающий за управление бизнес-логикой и представлением
final class DetailPresenter {
	weak var view: DetailViewInput?
    weak var moduleOutput: DetailModuleOutput?
    var poster: PosterViewModel?
    var isInFavorites: Bool = false

	private let router: DetailRouterInput
	private let interactor: DetailInteractorInput

    init(router: DetailRouterInput, interactor: DetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    /// Форматирует строку описания
    func description_standartization(description: String) -> String{
        guard let startOfStr = description.firstIndex(of: ">") else { return description }
        let start = description.index(after: startOfStr)
        guard let endOfStr = description.lastIndex(of: "<") else { return description }
        let end = description.index(before: endOfStr)
        return String(description[start...end])
    }
    
    private func posterToDetailViewModelData(poster: PosterViewModel?) -> DetailViewModel{
        var address = poster?.address ?? ""
        if address == ""{
            address = "Адрес не указан"
        }
        
        let description = description_standartization(description: poster?.description ?? "")
        
        var price = poster?.price ?? ""
        if price == "" {
            price = "Цена не указана"
        }
        if ((poster?.is_free) != nil && poster!.is_free){
            price = "Бесплатно"
        }
        
        var categoryText = ""
        for category in poster?.category ?? [] {
            categoryText += category + "  "
        }
        
        let t = poster?.age_restriction
        let k = t as? String
        var ageRestriction = "Возрастное ограничение: \(k ?? "")"
        if (k ?? "") == "0" || (k ?? "") == ""{
            ageRestriction =  "Возрастное ограничение: 0+"
        }
        
        let model = DetailViewModel(title: poster?.title ?? "", address: address, description: description, category: categoryText, price: price, image: poster?.image, age_restriction: ageRestriction, site_url: poster?.site_url, isInFavorites: isInFavorites)
        return model
    }
    
    func getPosterDict() -> [String : Any] {
        var dict: [String : Any] = [:]
        dict["id"] = poster?.id
        dict["address"] = poster?.address
        dict["short_title"] = poster?.short_title
        dict["title"] = poster?.short_title
        dict["description"] = poster?.description
        dict["category"] = poster?.category
        dict["price"] = poster?.price
        dict["is_free"] = poster?.is_free
        dict["image"] = poster?.image
        dict["age_restriction"] = poster?.age_restriction
        dict["site_url"] = poster?.site_url
        
        return dict
    }
}

extension DetailPresenter: DetailModuleInput {
}

extension DetailPresenter: DetailViewOutput {
    func didLoadView() {

        let model: DetailViewModel = self.posterToDetailViewModelData(poster: self.poster)
        self.view?.loadData(with: model)
    }
    
    func didTapButtonUrl() {
        router.showSite(siteUrl: poster?.site_url ?? "", output: self)
    }
    
    func didTapAddToFavorites() {
        interactor.addToFavorites(dict: getPosterDict())
    }
    
    func didTapRemoveFromFavorites() {
        interactor.removeFromFavorites(id: poster?.id)
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func didReceive(message: String) {
        router.showAlertErrorMessage(with: message)
    }
}

