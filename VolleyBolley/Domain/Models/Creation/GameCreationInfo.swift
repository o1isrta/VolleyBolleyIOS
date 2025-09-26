//
//  GameCreationInfo.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 14.09.2025.
//

import Foundation

struct GameCreationInfo: CreationInfo {
    let courtName: String
    let locationName: String
    let startTime: Date
    let endTime: Date
    let levels: [String]
    let gender: String
    let pricePerPerson: String
    let currency: String
    let paymentAccount: String
    let maximumPlayers: Int
    let isPrivate: Bool
}
