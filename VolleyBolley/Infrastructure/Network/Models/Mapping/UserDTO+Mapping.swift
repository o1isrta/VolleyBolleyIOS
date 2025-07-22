//
//  UserDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

extension UserDTO {
    func toDomain() -> User {
        let parsedDate = dateOfBirth.asServerDate
        let parsedURL = URL(string: avatarUrl)

        return User(
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            paymentID: paymentId,
            paymentAccount: paymentAccount,
            dateOfBirth: parsedDate,
            level: UserLevel(rawValue: self.level),
            countryID: countryId,
            cityID: cityId,
            avatarURL: parsedURL
        )
    }
}
