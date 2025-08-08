//
//  OnboardingRouterProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 02.08.2025.
//

import UIKit

protocol OnboardingRouterProtocol {
    var onFinish: (() -> Void)? { get set }
    func start() -> UIViewController
}
