//
//  CourtDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 07.08.2025.
//

import Foundation

struct CourtDTO: Decodable {
    let courtId: Int
    let priceDescription: String?
    let description: String?
    let contactList: [ContactDTO]?
    let photoUrl: String?
    let tagList: [String]?
    let location: CourtLocationDTO

    struct ContactDTO: Decodable {
        let contactType: String
        let contact: String
    }

    struct CourtLocationDTO: Decodable {
        let latitude: Double
        let longitude: Double
        let courtName: String
        let locationName: String
    }
}
