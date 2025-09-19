//
//  PlayerDTO.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

struct PlayerDTO: Codable {
    let firstName: String
    let lastName: String
    let gender: String
    let dateOfBirth: Date
    let level: PlayerLevel
    let countryId: Int
    let cityId: Int
    let avatarUrl: String?

    var avatar: URL? {
        avatarUrl.flatMap { URL(string: $0) }
    }

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case dateOfBirth = "date_of_birth"
        case level
        case countryId = "country_id"
        case cityId = "city_id"
        case avatarUrl = "avatar_url"
    }
}
