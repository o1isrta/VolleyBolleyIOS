//
//  CourtLocationDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

import Foundation

struct CourtLocationDTO: Decodable {
    let longitude: Double
    let latitude: Double
    let courtName: String
    let locationName: String

    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
        case courtName = "court_name"
        case locationName = "location_name"
    }
}
