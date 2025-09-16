//
//  ProfileInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class ProfileInteractor: ProfileInteractorProtocol {

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
        return "Profile Module"
    }
}
