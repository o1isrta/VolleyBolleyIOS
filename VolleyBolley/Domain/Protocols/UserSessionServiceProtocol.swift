//
//  UserSessionServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Foundation

protocol UserSessionServiceProtocol {
    var isOnboardingShown: Bool { get }
    var isAuthorized: Bool { get }
    func markOnboardingAsShown()
    func markUserAuthorized()
}
