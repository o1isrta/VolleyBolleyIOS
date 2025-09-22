//
//  UserSessionServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.09.2025.
//

protocol UserSessionServiceProtocol {
    var isOnboardingShown: Bool { get }
    var isAuthorized: Bool { get }
    func markOnboardingAsShown()
    func markUserAuthorized()
}
