//
//  LocationRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

protocol LocationRepositoryProtocol {
    func getPlayerLocation(forceUpdate: Bool) async throws -> Coordinates
    func getCachedPlayerLocation() -> Coordinates?
}
