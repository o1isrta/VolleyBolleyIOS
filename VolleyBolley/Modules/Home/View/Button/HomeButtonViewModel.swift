//
//  HomeButtonViewModel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

protocol HomeButtonConfigurable {}

struct VenueButtonViewModel: HomeButtonConfigurable {
    let temperature: String
    let conditionIconName: String
    let locationName: String
    let locationAddress: String
}

struct GamesButtonViewModel: HomeButtonConfigurable {
    let gamesCount: Int
}
