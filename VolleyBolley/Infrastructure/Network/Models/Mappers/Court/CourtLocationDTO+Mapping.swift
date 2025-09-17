//
//  CourtLocationDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

extension CourtLocationDTO {
    func toDomain() -> CourtLocation {
        CourtLocation(
            point: GeoPoint(lat: latitude, lon: longitude),
            name: courtName,
            locationName: locationName
        )
    }
}
