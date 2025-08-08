//
//  Temperature.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import Foundation

struct Temperature {
    let celsius: Double
    var fahrenheit: Double {
        return celsius * 9 / 5 + 32
    }
}
