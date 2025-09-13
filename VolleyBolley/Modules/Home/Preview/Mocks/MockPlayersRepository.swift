//
//  MockPlayersRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

final class MockPlayersRepository: PlayersRepositoryProtocol {
    func getCurrentPlayer() async throws -> Player {
        Player(
            firstName: "ArtemMock",
            lastName: "Petrov",
            gender: "man",
            paymentType: "paymentType",
            paymentAccount: "1234?",
            dateOfBirth: AppDateFormatters.serverDateOnly.date(from: "1970-02-20")!,
            level: .light,
            country: .thailand,
            cityID: 1,
            avatarURL: URL(string: "https://github.com/xcode73/myapp-mocks")
        )
    }
}
