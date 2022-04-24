import Foundation

/// Модель для декодирования данных из сети
struct PosterResults: Codable {
    /// Координаты
    struct Coords: Codable {
        /// Широта
        let lat: Double
        /// Долгота
        let lon: Double
    }

    /// Место
    struct Place: Codable {
        /// Адрес
        let address: String?
        /// Координаты
        let coords: Coords
    }

    /// Изображение
    struct Image: Codable {
        /// URL изображения
        let image: String?
    }

    /// Индетификатор события
    let id: Int
    /// Полное название
    let title: String
    /// Короткое название
    let short_title: String
    /// Место проведения
    let place: Place?
    /// Описание
    let description: String
    /// Категории мероприятия
    var categories: [String]
    /// Возрастное ограничение
    let age_restriction: String?
    /// Цена
    let price: String?
    /// Бесплатно или нет
    let is_free: Bool
    /// Фотографии к мероприятию
    let images: [Image]
    /// Ссылка на сайт
    let site_url: String?
    
    /// Декодирование
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        short_title = try container.decode(String.self, forKey: .short_title)
        place = try? container.decode(Place?.self, forKey: .place)
        description = try container.decode(String.self, forKey: .description)
        
        let raw_categories = try container.decode([String].self, forKey: .categories)
        categories = []
        for categ in raw_categories{
            if let key = ServiceData.shared.getCategories().someKey(forValue: categ) {
                categories.append(key)
            } else {
                categories.append("Разное")
            }
        }
        
        do {
            age_restriction = try String(container.decode(Int.self, forKey: .age_restriction))
        } catch DecodingError.typeMismatch {
            age_restriction = try container.decode(String.self, forKey: .age_restriction)
        } catch DecodingError.valueNotFound{
            age_restriction = ""
        }
        
        price = try container.decode(String?.self, forKey: .price)
        is_free = try container.decode(Bool.self, forKey: .is_free)
        images = try container.decode([Image].self, forKey: .images)
        site_url = try container.decode(String?.self, forKey: .site_url)
    }
}

/// Данные, приходящие из сети
struct PosterResponce: Codable {
    let results: [PosterResults]
}


