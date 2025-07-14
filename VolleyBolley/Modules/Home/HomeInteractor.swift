//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol HomeInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class HomeInteractor: HomeInteractorProtocol {

    // MARK: - Public Methods

    func fetchGreeting() -> String {
        return "Home Module"
    }
}
