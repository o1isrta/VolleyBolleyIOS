//
//  LocationRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Foundation

protocol LocationRepositoryProtocol {
    func getPlayerLocation(forceUpdate: Bool, timeout: TimeInterval) async throws -> Coordinates
    func getCachedPlayerLocation() -> Coordinates?
}
