//
//  TourneyCreationInfo.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 14.09.2025.
//

import Foundation

struct TourneyCreationInfo: CreationInfo {
    let courtName: String
    let locationName: String
    let startTime: Date
    let endTime: Date
    let levels: [String]
    let gender: String
    let pricePerPerson: String
    let currency: String
    let paymentAccount: String
    let maximumTeams: Int
    let isIndividual: Bool

    static let mockData = TourneyCreationInfo(
        courtName: "Karon Beach Club",
        locationName: "Patak Rd, Mueang Phuket",
        startTime: Date(),
        endTime: Date().addingTimeInterval(3600),
        levels: ["HARD"],
        gender: "Mix",
        pricePerPerson: "5",
        currency: "USD",
        paymentAccount: "988 016 7890",
        maximumTeams: 4,
        isIndividual: true
    )
}
