//
//  MyGamesInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MyGamesInteractorProtocol: AnyObject {}

final class MyGamesInteractor: MyGamesInteractorProtocol {

    // MARK: - Private Properties

    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.imageLoader = imageLoader
    }
}
