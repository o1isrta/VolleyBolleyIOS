//
//  MyGamesInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MyGamesInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
    func loadPlayerData() async throws -> (Player, UIImage?)
}

final class MyGamesInteractor: MyGamesInteractorProtocol {

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

    func fetchGreeting() -> String {
        return "My Games Module"
    }

    func loadPlayerData() async throws -> (Player, UIImage?) {
        let player = try await playersRepository.getCurrentPlayer()

        if let avatarURL = player.avatarURL {
            let image = try await imageLoader.loadImage(from: avatarURL)
            return (player, image)
        } else {
            return (player, nil)
        }
    }
}
