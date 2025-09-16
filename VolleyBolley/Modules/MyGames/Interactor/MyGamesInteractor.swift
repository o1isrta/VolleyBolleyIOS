//
//  MyGamesInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MyGamesInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class MyGamesInteractor: MyGamesInteractorProtocol {

    // MARK: - Private Properties

    // MARK: - Initializers

    init() { }

    // MARK: - Public Methods

    func fetchGreeting() -> String {
        return "My Games Module"
    }
}
