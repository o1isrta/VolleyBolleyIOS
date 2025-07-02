import Foundation
import Swinject

class OnboardingAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnboardingRouterProtocol.self) { _ in
            OnboardingRouter(container: container)
        }
    }
}
