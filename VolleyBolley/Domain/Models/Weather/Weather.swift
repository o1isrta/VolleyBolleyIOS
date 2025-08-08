//
//  Weather.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import Foundation

struct Weather {
    let locationName: String
    let coordinate: Coordinate
    let date: Date
    let condition: WeatherCondition
    let temperature: Temperature
    let type: WeatherType
}
