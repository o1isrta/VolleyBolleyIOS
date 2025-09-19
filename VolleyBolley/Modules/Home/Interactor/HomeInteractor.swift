//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
    func loadUserData(completion: @escaping (Result<(User, UIImage?), Error>) -> Void)
}

final class HomeInteractor: HomeInteractorProtocol {

    // MARK: - Private Properties

    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func fetchGreeting() -> String {
        return "Home Module"
    }

    func loadUserData(completion: @escaping (Result<(User, UIImage?), Error>) -> Void) {}
}
