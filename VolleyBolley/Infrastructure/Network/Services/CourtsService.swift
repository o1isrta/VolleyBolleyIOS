//
//  CourtsService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation
import Moya

protocol CourtsServiceProtocol {
    func fetchCourts(for country: String) async throws -> [CourtDTO]
}

final class CourtsService: CourtsServiceProtocol, ProviderInitializable {

    // MARK: - Private Properties
    private let provider: MoyaProvider<CourtsAPI>

    // MARK: - Initializers
    init(provider: MoyaProvider<CourtsAPI>) {
        self.provider = provider
    }

    // MARK: - Public Methods
    func fetchCourts(for country: String) async throws -> [CourtDTO] {
        try await provider.asyncRequest(
            .getCourts(country: country),
            type: [CourtDTO].self,
            decoder: AppJSONDecoders.server
        )
    }
}
