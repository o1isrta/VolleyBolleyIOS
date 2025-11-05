//
//  AppRouterAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject
import UIKit

final class AppRouterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppRouter.self) { resolver in
            AppRouter(
                window: resolver.safeResolve(UIWindow.self),
                onboardingRepository: resolver.safeResolve(OnboardingRepositoryProtocol.self),
                onboardingRouter: resolver.safeResolve(OnboardingRouterProtocol.self),
                authRouter: resolver.safeResolve(AuthRouterProtocol.self),
                playerRegistrationRouter: resolver.safeResolve(UserRegRouterProtocol.self),
                mainAppRouter: resolver.safeResolve(MainRouterProtocol.self)
            )
        }
        .inObjectScope(.container)
        .initCompleted { resolver, appRouter in
            let onboardingRouter = resolver.safeResolve(OnboardingRouterProtocol.self)
            let authRouter = resolver.safeResolve(AuthRouterProtocol.self)

            onboardingRouter.delegate = appRouter
            authRouter.delegate = appRouter
        }
    }
}
