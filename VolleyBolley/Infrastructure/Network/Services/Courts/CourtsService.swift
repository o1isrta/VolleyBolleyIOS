//
//  CourtsService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation
import Moya

protocol CourtsServiceProtocol {
    func fetchCourts() async throws -> [CourtDTO]
}

final class CourtsService: CourtsServiceProtocol, ProviderInitializable {

    // MARK: - Private Properties

    private let provider: MoyaProvider<CourtsAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<CourtsAPI>) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func fetchCourts() async throws -> [CourtDTO] {
        do {
            return try await provider.asyncRequest(
                .getCourts,
                type: [CourtDTO].self,
                decoder: AppJSONDecoders.server
            )
        } catch let error as MoyaError {
            throw error.toNetworkError()
        }
    }
}
