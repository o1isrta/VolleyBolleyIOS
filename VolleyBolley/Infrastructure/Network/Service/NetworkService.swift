//
//  NetworkService.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation
import Moya

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Private Properties

    private let provider: MoyaProvider<DataAPI>

    // MARK: - Initializers

    init(
        provider: MoyaProvider<DataAPI> = MoyaProvider<DataAPI>(),
    ) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func googleAuth(idToken: String) async throws -> PlayerSessionDTO {
        try await provider.asyncRequestDecodable(
            .googleAuth(idToken: idToken),
            type: PlayerSessionDTO.self,
            decoder: AppJSONDecoders.server
        )
    }
}
