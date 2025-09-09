//
//  CourtsService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation
import Moya

protocol CourtsServiceProtocol {
    func fetchCourts(completion: @escaping (Result<CourtDTO, Error>) -> Void)
}

final class CourtsService: CourtsServiceProtocol {

    // MARK: - Private Properties

    private let provider: MoyaProvider<CourtsAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<CourtsAPI>) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func fetchCourts(completion: @escaping (Result<CourtDTO, Error>) -> Void) {
        provider.request(.getCourts(country: "thailand")) { result in
            do {
                let response = try result.get()

                guard (200..<300).contains(response.statusCode) else {
                    throw MoyaError.statusCode(response)
                }

                let dto = try AppJSONDecoders.server.decode(CourtDTO.self, from: response.data)
                completion(.success(dto))
            } catch {
                // TODO: - Handle error
#if DEBUG
                print("UsersService.fetchCurrentUser failed: \(error)")
#endif
                completion(.failure(error))
            }
        }
    }
}
