//
//  CourtsRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 24.08.2025.
//

import Foundation

final class CourtsRepository: CourtsRepositoryProtocol, ServiceInitializable {

    // MARK: - Private Properties

    private let service: CourtsServiceProtocol
    private var cachedCourts: [Court]?

    // MARK: - Initializers

    init(service: CourtsServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func getCourts(forceRefresh: Bool = false) async throws -> [Court] {
        if let cachedCourts, !forceRefresh {
            return cachedCourts
        }

        do {
            let dtos = try await service.fetchCourts()
            let courts = dtos.map { $0.toDomain() }
            cachedCourts = courts

            return courts
        } catch let error as NetworkError {
            throw CourtsError.from(error)
        } catch {
            throw CourtsError.unknown
        }
    }
}
