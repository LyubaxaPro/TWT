//
//  FilterInfo.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import Foundation

/// Иформация о выбранном городе
struct City {
    /// Строка для отображения на экране
    var cityName: String = "Москва"
    /// Строка для составления URL
    var cityInfo: String = "msk"
}

/// Информация из фильтра
struct FilterInfo {
    /// Город
    var city = City()
    /// Список категорий
    var categories: [String: Bool ] = [:]
}

/// Значения из фильтра
struct FilterValues {
    /// Локация
    var location: String = ""
    /// Категории
    var categories: [String]
}
