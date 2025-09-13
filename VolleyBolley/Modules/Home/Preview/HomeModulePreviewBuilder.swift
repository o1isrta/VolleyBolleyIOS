#if DEBUG
import UIKit

enum HomeModulePreviewBuilder {
    @MainActor
    static func build() -> UIViewController {
        let playersRepository = MockPlayersRepository()
        let imageLoader = MockImageLoadingService()
        let nearestCourtWithWeatherUseCase = MockNearestCourtWithWeatherUseCase()
        let router = MockHomeRouter()

        let interactor = MockHomeInteractor(
            playersRepository: playersRepository,
            imageLoader: imageLoader,
            nearestCourtWithWeatherUseCase: nearestCourtWithWeatherUseCase
        )

        let presenter = HomePresenter(
            interactor: interactor,
            router: router
        )

        let view = HomeViewController(presenter: presenter)

        router.attachViewController(view)
        presenter.view = view

        return UINavigationController(rootViewController: view)
    }
}
#endif
