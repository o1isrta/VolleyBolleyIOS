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

    // MARK: - Private Properties

    private let provider: MoyaProvider<UsersAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<UsersAPI>) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func fetchCurrentUser(completion: @escaping (Result<UserDTO, Error>) -> Void) {
        provider.request(.getCurrentUser) { result in
            switch result {
            case .success(let response):
                guard
                    (200..<300).contains(response.statusCode)
                else {
                    completion(.failure(MoyaError.statusCode(response)))
                    return
                }

                do {
                    let dto = try AppJSONDecoders.server.decode(UserDTO.self, from: response.data)
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
