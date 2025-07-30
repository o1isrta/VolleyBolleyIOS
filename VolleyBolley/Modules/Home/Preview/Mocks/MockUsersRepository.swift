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
            dateOfBirth: AppDateFormatters.serverDateOnly.date(from: "1970-02-20")!,
            level: .light,
            countryID: 1,
            cityID: 1,
            avatarURL: URL(string: "https://github.com/xcode73/myapp-mocks")
        )
        completion(.success(user))
    }
}
