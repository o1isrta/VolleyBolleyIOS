//
//  CourtLocationDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

struct CourtLocationDTO: Decodable {
    let latitude: Double
    let longitude: Double
    let courtName: String
    let locationName: String

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case courtName = "court_name"
        case locationName = "location_name"
    }
}
