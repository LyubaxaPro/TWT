//
//  ServiceData.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import Foundation

struct Coordinates {
    var latitude: Double
    var longitude: Double
}

protocol ServiceDataDescription: AnyObject {
    func getCities() -> [String: String]
    func getCategories() -> [String: String]
    func getCoordinates(city: String) -> Coordinates
}

final class ServiceData: ServiceDataDescription {

    private var defaultCitiesDict: [String: String] =
    ["Екатеринбург": "ekb", "Красноярск": "krasnoyarsk", "Краснодар": "krd", "Москва": "msk",
     "Нижний Новгород": "nnv", "Новосибирск": "nsk", "Сочи": "sochi", "Санкт-Петербург": "spb"]

    private var citiesCoordinates: [String: Coordinates] = [
        "ekb": Coordinates(latitude: 56.749993, longitude: 60.519708),
        "krasnoyarsk": Coordinates(latitude: 56.0184, longitude: 92.8672),
        "krd": Coordinates(latitude: 45.0448, longitude: 38.976),
        "msk": Coordinates(latitude: 55.7522, longitude: 37.6156),
        "nsk": Coordinates(latitude: 55.0415, longitude: 82.9346),
        "nnv": Coordinates(latitude: 56.3287, longitude: 44.002),
        "sochi": Coordinates(latitude: 43.5992, longitude: 39.7257),
        "spb": Coordinates(latitude: 59.9386, longitude: 30.3141)]

    private var categoriesDict: [String: String] = [
        "События для бизнеса": "business-events",
        "Кино": "cinema",
        "Концерты": "concert",
        "Обучение": "education",
        "Развлечения": "entertainment",
        "Выставки": "exhibition",
        "Мода и стиль": "fashion",
        "Фестивали": "festival",
        "Праздники": "holiday",
        "Детям": "kids",
        "Разное": "other",
        "Вечеринки": "party",
        "Фотография": "photo",
        "Квесты": "quest",
        "Отдых": "recreation",
        "Шопинг": "shopping",
        "Благотворительность": "social-activity",
        "Спектакли": "theater",
        "Экскурсии": "tour",
        "Ярмарки": "yarmarki-razvlecheniya-yarmarki"]

    static let shared: ServiceDataDescription = ServiceData()
    init() {}

    func getCities() -> [String: String] {
        return defaultCitiesDict
    }

    func getCategories() -> [String: String] {
        return categoriesDict
    }

    func getCoordinates(city: String) -> Coordinates {
        return citiesCoordinates[city] ?? Coordinates(latitude: 55.7522, longitude: 37.6156)
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
