#if DEBUG
import UIKit

final class MockHomeInteractor: HomeInteractorProtocol {
    private let usersRepository: UsersRepositoryProtocol
    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(usersRepository: UsersRepositoryProtocol, imageLoader: ImageLoadingServiceProtocol) {
        self.usersRepository = usersRepository
        self.imageLoader = imageLoader
    }

    func fetchGreeting() -> String {
        return "Home Module"
    }

    func loadUserData(completion: @escaping (Result<(User, UIImage?), any Error>) -> Void) {
        usersRepository.getCurrentUser { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                guard let avatarURL = user.avatarURL else {
                    completion(.success((user, nil)))
                    return
                }

                self.imageLoader.loadImage(from: avatarURL) { image in
                    completion(.success((user, image)))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
#endif
