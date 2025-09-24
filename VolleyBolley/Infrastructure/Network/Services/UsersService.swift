//
//  UsersService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation
import Moya

protocol UsersServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<PlayerDTO, Error>) -> Void)
}

@available(*, deprecated, message: "Use NetworkService instead")
final class UsersService: UsersServiceProtocol {

    // MARK: - Private Properties

	private let provider: MoyaProvider<DataAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<DataAPI>) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func fetchCurrentUser(completion: @escaping (Result<PlayerDTO, Error>) -> Void) {
        provider.request(.getCurrentUser) { result in
            do {
                let response = try result.get()

                guard (200..<300).contains(response.statusCode) else {
                    throw MoyaError.statusCode(response)
                }

                let dto = try AppJSONDecoders.server.decode(PlayerDTO.self, from: response.data)
                completion(.success(dto))
            } catch {
#if DEBUG
                print("UsersService.fetchCurrentUser failed: \(error)")
#endif
                completion(.failure(error))
            }
        }
    }
}
