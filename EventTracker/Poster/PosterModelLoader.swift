import Foundation

/// Составление правильного URL  для работы с API
struct PosterServiceLoader{
    /// Данные для составления URL
    private var posters: PosterServiceInfo

    /// Правильный URL
    private var urlString: String {
        let locations = posters.location
        
        var urlString = "https://kudago.com/public-api/v1.3/events/?location=\(locations)"
        
        if posters.category.count != 0 {
            urlString += "&categories="
            for cat in posters.category{
                urlString += cat + ","
            }
        }
        if urlString.last == "," {
                    _ = urlString.popLast()
                }
        
        urlString += "&page_size=500&actual_since=\(Int(NSDate().timeIntervalSince1970))&fields=id,title,short_title,place,description,categories,age_restriction,price,is_free,images,site_url&expand=place"
        //print(urlString)
        return urlString;
    }

    /// Инициализация класса
    init(posters: PosterServiceInfo){
        self.posters = posters
    }

    /// Отдает URL для использования вне класса
    func posterUrl() -> String {
        return urlString
    }
}
    
/// Данные для составления URL
struct PosterServiceInfo {
    /// Город в формате, требуемом в API
    var location: String
    /// Список категорий в формате, требуемом API
    var category: [String]
}
