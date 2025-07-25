#if DEBUG
import UIKit

enum HomeModulePreviewBuilder {
    @MainActor
    static func build() -> UIViewController {
        let usersRepository = MockUsersRepository()
        let imageLoader = MockImageLoadingService()
        let router = MockHomeRouter()

        let interactor = MockHomeInteractor(
            usersRepository: usersRepository,
            imageLoader: imageLoader
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
