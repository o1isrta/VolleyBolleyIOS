//
//  Player.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

struct Player {
    let firstName: String
    let lastName: String
    let gender: String
    let paymentType: String
    let paymentAccount: String
    let dateOfBirth: Date?
    let level: PlayerLevel
    let country: Country
    let cityID: Int
    let avatarURL: URL?
}
