//
//  CourtDTO.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

struct CourtDTO: Decodable {
    let courtId: Int
    let priceDescription: String?
    let description: String?
    let contactList: [ContactDTO]
    let photoURL: URL?
    let tags: [String]?
    let courtLocation: CourtLocationDTO

    enum CodingKeys: String, CodingKey {
        case courtId = "court_id"
        case priceDescription = "price_description"
        case description
        case contactList = "contact_list"
        case photoURL = "photo_url"
        case tags
        case courtLocation = "court_location"
    }

    struct ContactDTO: Decodable {
        let contact: String
    }
}
