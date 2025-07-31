//
//  OnboardingProtocol.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {

}

protocol OnboardingPresenterProtocol: AnyObject {
    func getStartedButtonTapped()
}

protocol OnboardingInteractorProtocol: AnyObject {
    func markOnboardingAsCompleted()
}

protocol OnboardingRouterProtocol: AnyObject {
    func navigateToAuthorizationScreen()
}
