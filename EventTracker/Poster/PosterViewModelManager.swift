import Foundation

protocol PosterViewModelManagerDescription: AnyObject {
    func posterResultsToPosterViewModel(poster: PosterResults) -> PosterViewModel
}

final class PosterViewModelManager : PosterViewModelManagerDescription {
    static let shared: PosterViewModelManagerDescription = PosterViewModelManager()
    private init(){}
    private func convertPrice(posterPrice: String?, isFree: Bool) -> String {
        var price: String = String(describing: posterPrice ?? "Цена не указана")
        if posterPrice == "" {
            price = "Цена не указана"
        }
        if isFree {
            price = "Бесплатно"
        }
        return price
    }
    
    func posterResultsToPosterViewModel(poster: PosterResults) -> PosterViewModel {
        return PosterViewModel(id: poster.id, address: poster.place?.address, short_title: poster.short_title,  title: poster.title, description: poster.description, category: poster.categories, price: convertPrice(posterPrice: poster.price, isFree: poster.is_free), is_free: poster.is_free, image: poster.images[0].image ?? "", age_restriction: poster.age_restriction as Any, site_url: poster.site_url ?? "" )
    }
    
    
}
