//
//  PlayerDTO+Mapping.swift
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
            paymentType: paymentType,
            paymentAccount: paymentAccount,
            dateOfBirth: dateOfBirth,
            level: level,
            country: country,
            cityID: cityId,
            avatarURL: avatar
        )
    }
}
