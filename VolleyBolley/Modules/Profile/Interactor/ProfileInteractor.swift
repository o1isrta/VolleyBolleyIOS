//
//  ProfileInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileInteractorProtocol: AnyObject {}

final class ProfileInteractor: ProfileInteractorProtocol {

    // MARK: - Private Properties

    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.imageLoader = imageLoader
    }

}
