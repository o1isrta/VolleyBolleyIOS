//
//  CreationSuccessInteractor.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 11.09.2025.
//

import Foundation

protocol CreationSuccessInteractorProtocol {
    func fetchCreationInfo(completion: @escaping (Result<CreationInfo, Error>) -> Void)
    func fetchInviteLink(completion: @escaping (String?) -> Void)
}

final class CreationSuccessInteractor: CreationSuccessInteractorProtocol {

    // MARK: - Internal Methods

    func fetchCreationInfo(completion: @escaping (Result<CreationInfo, Error>) -> Void) {
        // TODO: Replace this mock implementation with a real network call
        completion(.success(TourneyCreationInfo.mockData))
    }

    func fetchInviteLink(completion: @escaping (String?) -> Void) {
		// TODO: -
        completion("https://example.com/invite/123")
    }
}
