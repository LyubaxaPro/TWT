//
//  FilterInfo.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import Foundation

struct City {
    var cityName: String = "Москва"
    var cityInfo: String = "msk"
}

struct FilterInfo {
    var city = City()
    var categories: [String: Bool ] = [:]
}

struct FilterValues {
    var location: String = ""
    var categories: [String]
}
