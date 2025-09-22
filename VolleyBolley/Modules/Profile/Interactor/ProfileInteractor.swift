//
//  ProfileInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileInteractorProtocol: AnyObject {
    func loadUserData(completion: @escaping (Result<(User, UIImage?), Error>) -> Void)
}

final class ProfileInteractor: ProfileInteractorProtocol {

    // MARK: - Private Properties

    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func loadUserData(completion: @escaping (Result<(User, UIImage?), Error>) -> Void) {}
}
