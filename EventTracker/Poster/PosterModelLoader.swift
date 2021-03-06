import Foundation

struct PosterServiceLoader{
    private var posters: PosterServiceInfo
    
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
        
        urlString += "&page_size=500&actual_since=\(NSDate().timeIntervalSince1970)&fields=id,title,short_title,place,description,categories,age_restriction,price,is_free,images,site_url&expand=place"
        //print(urlString)
        return urlString;
    }
    
    init(posters: PosterServiceInfo){
        self.posters = posters
    }
    
    func posterUrl() -> String {
        return urlString
    }
}
    

struct PosterServiceInfo {
    var location: String
    var category: [String]
}
