//
//  NearestCourtUseCase.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.09.2025.
//

import Foundation

protocol CourtsUseCaseProtocol {
    func getNearestCourt(playerLocation: GeoPoint) async throws -> Court
}

final class NearestCourtUseCase: CourtsUseCaseProtocol {

    // MARK: - Private Properties

    private let courtRepository: CourtsRepositoryProtocol

    // MARK: - Initializers

    init(
        courtRepository: CourtsRepositoryProtocol
    ) {
        self.courtRepository = courtRepository
    }

    // MARK: - Public Methods

    func getNearestCourt(playerLocation: GeoPoint) async throws -> Court {
        let courts = try await courtRepository.getCourts(forceRefresh: false)

        guard let nearest = courts.min(by: {
            $0.location.point.distanceInKilometers(to: playerLocation) <
                $1.location.point.distanceInKilometers(to: playerLocation)
        }) else {
            throw CourtsError.notFound
        }

        return nearest
    }
}
