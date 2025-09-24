//
//  MyGamesInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MyGamesInteractorProtocol: AnyObject {
    func loadUserData(completion: @escaping (Result<(Player, UIImage?), Error>) -> Void)
}

final class MyGamesInteractor: MyGamesInteractorProtocol {

    // MARK: - Private Properties

    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func loadUserData(completion: @escaping (Result<(Player, UIImage?), Error>) -> Void) {}
}
