//
//  UsersRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

protocol UsersRepositoryProtocol {
    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void)
}

final class UsersRepository: UsersRepositoryProtocol {
    private let service: UsersService

    init(service: UsersService) {
        self.service = service
    }

    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        service.fetchCurrentUser { result in
            switch result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
