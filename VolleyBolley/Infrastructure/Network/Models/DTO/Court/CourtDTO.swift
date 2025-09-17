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

    enum CodingKeys: String, CodingKey {
        case courtId = "court_id"
        case priceDescription = "price_description"
        case description
        case contactList = "contact_list"
        case photoUrl = "photo_url"
        case tagList = "tags"
        case location = "court_location"
    }

    struct ContactDTO: Decodable {
        let contactType: String
        let contact: String

        enum CodingKeys: String, CodingKey {
            case contactType = "contact_type"
            case contact
        }
    }
}
