import Foundation

/// Модель для отображения на карточке афиши
struct PosterViewModel {
    /// Идентификатор
    let id: Int
    /// Адрес
    let address: String?
    /// Заголовок
    let short_title: String
    /// Полное название
    let title: String
    /// Описание мероприятия
    let description: String
    /// Категории к которым относится мероприятие
    let category: [String]
    /// Цена
    let price: String?
    /// Бесплатный вход или нет
    let is_free: Bool
    /// Изображение для мероприятия
    let image: String?
    /// Возрастное ограничение
    let age_restriction: Any
    /// Ссылка на сайт мероприятия
    let site_url: String?
}


