//
//  UserDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

struct UserDTO: Decodable {
    let firstName: String
    let lastName: String
    let gender: Int
    let paymentId: Int
    let paymentAccount: String
    let dateOfBirth: Date
    let level: Int
    let countryId: Int
    let cityId: Int
    let avatarUrl: String
}
