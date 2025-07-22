//
//  MockUsersRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

final class MockUsersRepository: UsersRepositoryProtocol {
    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        let user = User(
            firstName: "ArtemMock",
            lastName: "Petrov",
            gender: 0,
            paymentID: 0,
            paymentAccount: "1234?",
            dateOfBirth: "1970-02-20".asServerDate,
            level: .light,
            countryID: 1,
            cityID: 1,
            avatarURL: URL(string: "")
        )
        completion(.success(user))
    }
}
