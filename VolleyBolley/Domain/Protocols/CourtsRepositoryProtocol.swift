//
//  CourtsRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

protocol CourtsRepositoryProtocol {
    func getCourts(forceRefresh: Bool) async throws -> [Court]
}
