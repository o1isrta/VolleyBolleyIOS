//
//  TableViewPlayersMock.swift
//  VolleyBolley
//
//  Created by Вадим on 29.09.2025.
//

import Foundation

struct PlayersMock {
    static let players: [Player] = [
        Player(
            firstName: "Polina",
            lastName: "Vasilieva",
            gender: "Female", dateOfBirth: nil,
            level: .light,
            countryID: 0,
            cityID: 0,
            avatarURL: nil
        ),
        Player(
            firstName: "Kristina",
            lastName: "Popova",
            gender: "Female",
            dateOfBirth: nil,
            level: .light,
            countryID: 0,
            cityID: 0,
            avatarURL: nil
        ),
        Player(firstName: "Anton",
               lastName: "Ivanov",
               gender: "Male",
               dateOfBirth: nil,
               level: .light,
               countryID: 0,
               cityID: 0,
               avatarURL: nil
              ),
        Player(firstName: "Aleksandr",
               lastName: "Abramov",
               gender: "Male",
               dateOfBirth: nil,
               level: .light,
               countryID: 0,
               cityID: 0,
               avatarURL: nil
              )
    ]
}
