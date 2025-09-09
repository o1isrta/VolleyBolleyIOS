//
//  WeatherViewModel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

struct WeatherViewModel {
    let icon: UIImage?
    let temperatureText: String

    init(condition: WeatherCondition, temperatureInCelsius: Double) {
        self.icon = condition.icon
        self.temperatureText = "\(Int(round(temperatureInCelsius))) ℃"
    }
}
