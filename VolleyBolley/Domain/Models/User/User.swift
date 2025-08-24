//
//  User.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

// TODO(API): Temporary implementation — waiting for backend spec
struct User {
    let firstName: String
    let lastName: String
    let gender: Int
    let paymentID: Int
    let paymentAccount: String
    let dateOfBirth: Date?
    let level: UserLevel
    let countryID: Int
    let cityID: Int
    let avatarURL: URL?
}
