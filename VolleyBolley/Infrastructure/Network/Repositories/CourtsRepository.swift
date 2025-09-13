//
//  CourtsRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 24.08.2025.
//

import Foundation

protocol CourtsRepositoryProtocol {
    func getCourts(for country: String) async throws -> [Court]
    func getNearestCourt(for country: String, userLocation: GeoPoint) async throws -> Court
}

final class CourtsRepository: CourtsRepositoryProtocol, ServiceInitializable {

    private let service: CourtsServiceProtocol

    // MARK: - Initializers

    init(service: CourtsServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func getCourts(for country: String) async throws -> [Court] {
        do {
            let dtos = try await service.fetchCourts(for: country)
            return dtos.map { $0.toDomain() }
        } catch {
            throw CourtError.serviceFailed
        }
    }

    func getNearestCourt(for country: String, userLocation: GeoPoint) async throws -> Court {
        do {
            let courts = try await getCourts(for: country)

            guard let nearest = courts.min(by: {
                $0.location.distanceInKilometers(to: userLocation) <
                $1.location.distanceInKilometers(to: userLocation)
            }) else {
                throw CourtError.notFound
            }
            return nearest
        } catch let error as CourtError {
            throw error
        } catch {
            throw CourtError.unknown(error)
        }
    }
}
