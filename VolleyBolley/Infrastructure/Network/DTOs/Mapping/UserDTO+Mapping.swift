//
//  UserDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

extension PlayerDTO {
    func toDomain() -> Player {
        Player(
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            dateOfBirth: dateOfBirth,
            level: level,
            countryID: countryId,
            cityID: cityId,
            avatarURL: avatar
        )
    }
}
