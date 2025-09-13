//
//  OnboardingInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

final class OnboardingInteractor: OnboardingInteractorProtocol {

    func markOnboardingAsCompleted() {
        UserDefaults.standard.isOnboardingShown = true
    }
}
