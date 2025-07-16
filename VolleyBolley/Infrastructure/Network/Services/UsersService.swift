//
//  UsersService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation
import Moya

protocol UsersServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<UserDTO, Error>) -> Void)
}

final class UsersService: UsersServiceProtocol {
    private let provider: MoyaProvider<UsersAPI>

    init(provider: MoyaProvider<UsersAPI>) {
        self.provider = provider
    }

    func fetchCurrentUser(completion: @escaping (Result<UserDTO, Error>) -> Void) {
        provider.request(.getCurrentUser) { result in
            switch result {
            case .success(let response):
                do {
                    let dto = try JSONDecoder().decode(UserDTO.self, from: response.data)
                    completion(.success(dto))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
