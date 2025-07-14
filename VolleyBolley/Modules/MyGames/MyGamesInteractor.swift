//
//  MyGamesInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol MyGamesInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class MyGamesInteractor: MyGamesInteractorProtocol {

    // MARK: - Public Methods

    func fetchGreeting() -> String {
        return "My Games Module"
    }
}
