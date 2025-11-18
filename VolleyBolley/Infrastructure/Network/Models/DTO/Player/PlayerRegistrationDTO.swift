//
//  PlayerRegistrationDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

struct PlayerRegistrationDTO: Encodable {
    let firstName: String
    let lastName: String
    let gender: String
    let dateOfBirth: String
    let level: String
    let countryId: Int
    let cityId: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case dateOfBirth = "date_of_birth"
        case level
        case countryId = "country_id"
        case cityId = "city_id"
    }
}
