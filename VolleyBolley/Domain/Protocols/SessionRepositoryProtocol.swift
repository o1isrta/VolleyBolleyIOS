//
//  SessionRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

protocol SessionRepositoryProtocol {
    var currentSession: PlayerSession? { get }
    func save(session: PlayerSession) throws
    func clear() throws
}
