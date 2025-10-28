//
//  WeatherViewModel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit
import WeatherKit

struct WeatherViewModel {
    let icon: UIImage?
    let temperatureText: String

    init(weather: AppWeather) {
        self.icon = weather.condition.icon
        self.temperatureText = "\(Int(round(weather.temperature)))℃"
    }
}
