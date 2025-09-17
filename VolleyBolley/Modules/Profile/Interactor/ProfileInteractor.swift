//
//  ProfileInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileInteractorProtocol: AnyObject {
    func loadPlayerData() async throws -> (Player, UIImage?)
}

final class ProfileInteractor: ProfileInteractorProtocol {

    // MARK: - Private Properties

    private let playersRepository: PlayersRepositoryProtocol
    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        playersRepository: PlayersRepositoryProtocol,
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.playersRepository = playersRepository
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func loadPlayerData() async throws -> (Player, UIImage?) {
        let player = try await playersRepository.getCurrentPlayer(forceRefresh: false)

        if let avatarURL = player.avatarURL {
            let image = try await imageLoader.loadImage(from: avatarURL)
            return (player, image)
        } else {
            return (player, nil)
        }
    }
}
