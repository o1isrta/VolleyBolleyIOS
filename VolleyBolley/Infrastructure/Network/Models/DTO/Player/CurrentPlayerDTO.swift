//
//  CurrentPlayerDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

struct CurrentPlayerDTO: Decodable {
    let playerId: Int
    let isRegistered: Bool
    let avatar: String?
    let firstName: String?
    let lastName: String?
    let gender: String?
    let dateOfBirth: Date?
    let level: String?
    let countryId: Int?
    let cityId: Int?

    var avatarUrl: URL? {
        avatar.flatMap { URL(string: $0) }
    }

    enum CodingKeys: String, CodingKey {
        case playerId = "player_id"
        case isRegistered = "is_registered"
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case dateOfBirth = "date_of_birth"
        case level
        case countryId = "country_id"
        case cityId = "city_id"
        case avatar
    }
}
