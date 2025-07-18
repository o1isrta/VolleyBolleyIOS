//
//  MyGamesInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MyGamesInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
    func loadUserData(completion: @escaping (Result<(User, UIImage?), Error>) -> Void)
}

final class MyGamesInteractor: MyGamesInteractorProtocol {

    // MARK: - Private Properties

    private let usersRepository: UsersRepositoryProtocol
    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        usersRepository: UsersRepositoryProtocol,
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.usersRepository = usersRepository
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func fetchGreeting() -> String {
        return "My Games Module"
    }

    func loadUserData(completion: @escaping (Result<(User, UIImage?), Error>) -> Void) {
        usersRepository.getCurrentUser { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                guard let avatarURL = user.avatarURL else {
                    completion(.success((user, nil)))
                    return
                }

                self.imageLoader.loadImage(from: avatarURL) { image in
                    completion(.success((user, image)))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
