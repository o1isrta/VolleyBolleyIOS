//
//  ProfileInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol ProfileInteractorProtocol: AnyObject {
    func fetchGreeting() -> String
}

final class ProfileInteractor: ProfileInteractorProtocol {

    // MARK: - Public Methods

    func fetchGreeting() -> String {
        return "Profile Module"
    }
}
