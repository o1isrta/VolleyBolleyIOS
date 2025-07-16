//
//  UserDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

extension UserDTO {
    func toDomain() -> User {
        let parsedDate = AppDateFormatters.isoDateOnly.date(from: dateOfBirth)
        let parsedURL = URL(string: avatarUrl)

        return User(
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            paymentID: paymentId,
            paymentAccount: paymentAccount,
            dateOfBirth: parsedDate,
            level: level,
            countryID: countryId,
            cityID: cityId,
            avatarURL: parsedURL
        )
    }
}
