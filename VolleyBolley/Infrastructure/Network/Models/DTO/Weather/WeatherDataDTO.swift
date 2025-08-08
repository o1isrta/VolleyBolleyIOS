//
//  WeatherDataDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import Foundation

struct WeatherDataDTO: Decodable {
    let date: String // "2025-08-07"
    let temperatureC: Double
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case date
        case temperatureC = "temperature_c"
        case condition
    }
}
