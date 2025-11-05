//
//  OnboardingRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 24.10.2025.
//

import Foundation

protocol OnboardingRepositoryProtocol: AnyObject {
    var isOnboardingShown: Bool { get }
    func markAsShown()
    func reset()
}
