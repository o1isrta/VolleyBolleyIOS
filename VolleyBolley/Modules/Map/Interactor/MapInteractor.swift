//
//  CourtModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import Foundation

protocol MapInteractorProtocol: AnyObject {
    func loadCourtsWithDistance() async throws -> [CourtWithDistance]
    func loadNearestCourt() async throws -> Court?
}

final class MapInteractor: MapInteractorProtocol {

    // MARK: - Private Properties

	private let networkService: NetworkServiceProtocol
    private let imageLoader: ImageLoadingServiceProtocol
    private let locationRepository: LocationRepositoryProtocol
    private let courtsRepository: CourtsRepositoryProtocol
    private let courtsWithDistanceUseCase: CourtsWithDistanceUseCaseProtocol
    private let findNearestCourtUseCase: FindNearestCourtUseCaseProtocol

    // MARK: - Initializers

	init(
        networkService: NetworkServiceProtocol,
        imageLoader: ImageLoadingServiceProtocol,
        locationRepository: LocationRepositoryProtocol,
        courtsRepository: CourtsRepositoryProtocol,
        courtsWithDistanceUseCase: CourtsWithDistanceUseCaseProtocol,
        findNearestCourtUseCase: FindNearestCourtUseCaseProtocol
    ) {
		self.networkService = networkService
        self.imageLoader = imageLoader
        self.locationRepository = locationRepository
        self.courtsRepository = courtsRepository
        self.courtsWithDistanceUseCase = courtsWithDistanceUseCase
        self.findNearestCourtUseCase = findNearestCourtUseCase
	}

	// MARK: - Public Methods

    func loadCourtsWithDistance() async throws -> [CourtWithDistance] {
        let playerLocation = try await locationRepository.getPlayerLocation(forceUpdate: false)
        let courts = try await courtsRepository.getCourts(forceRefresh: false)
        return courtsWithDistanceUseCase.execute(userLocation: playerLocation, courts: courts)
    }

    func loadNearestCourt() async throws -> Court? {
        let playerLocation = try await locationRepository.getPlayerLocation(forceUpdate: false)
        let courts = try await courtsRepository.getCourts(forceRefresh: false)
        return findNearestCourtUseCase.execute(userLocation: playerLocation, courts: courts)
    }
}
