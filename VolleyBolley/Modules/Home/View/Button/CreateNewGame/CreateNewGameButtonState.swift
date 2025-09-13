//
//  CreateNewGameButtonState.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.09.2025.
//

enum CreateNewGameButtonState {
    case loading
    case basic
    case withLocationAndWeather(location: LocationTitleViewModel, weather: WeatherViewModel)
    case withLocationOnly(location: LocationTitleViewModel)
}
