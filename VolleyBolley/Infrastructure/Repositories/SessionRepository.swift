//
//  SessionRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

final class SessionRepository: SessionRepositoryProtocol {

    // MARK: - Public Properties

    var currentSession: PlayerSession? {
        storage.load(forKey: key)
    }

    // MARK: - Private Properties

    private let storage: SecureStorageProtocol
    private let key = "player_session"

    // MARK: - Initializers

    init(storage: SecureStorageProtocol) {
        self.storage = storage
    }

    // MARK: - Public Methods

    func save(session: PlayerSession) throws {
        try storage.save(session, forKey: key)
    }

    func clear() throws {
        try storage.remove(forKey: key)
    }
}
