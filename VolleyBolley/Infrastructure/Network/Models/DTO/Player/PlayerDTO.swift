//
//  PlayerDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

struct PlayerDTO: Decodable {
    let firstName: String
    let lastName: String
    let gender: String
    let paymentType: String
    let paymentAccount: String
    let dateOfBirth: Date
    let level: PlayerLevel
    let country: Country
    let cityId: Int
    let avatarUrl: String?

    var avatar: URL? {
        avatarUrl.flatMap { URL(string: $0) }
    }

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case paymentType = "payment_type"
        case paymentAccount = "payment_account"
        case dateOfBirth = "date_of_birth"
        case level
        case country = "country_id"
        case cityId = "city_id"
        case avatarUrl = "avatar_url"
    }
}
