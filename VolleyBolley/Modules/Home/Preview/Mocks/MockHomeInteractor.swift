#if DEBUG
import UIKit

final class MockHomeInteractor: HomeInteractorProtocol {

    // MARK: - Private Properties

    private let playersRepository: PlayersRepositoryProtocol
    private let imageLoader: ImageLoadingServiceProtocol
    private let nearestCourtWithWeatherUseCase: NearestCourtWithWeatherUseCaseProtocol

    // MARK: - Initializers

    init(
        playersRepository: PlayersRepositoryProtocol,
        imageLoader: ImageLoadingServiceProtocol,
        nearestCourtWithWeatherUseCase: NearestCourtWithWeatherUseCaseProtocol
    ) {
        self.playersRepository = playersRepository
        self.imageLoader = imageLoader
        self.nearestCourtWithWeatherUseCase = nearestCourtWithWeatherUseCase
    }

    // MARK: - Public Methods

    func loadPlayerData() async throws -> (Player, UIImage?) {
        let player = try await playersRepository.getCurrentPlayer()

        if let avatarURL = player.avatarURL {
            let image = try await imageLoader.loadImage(from: avatarURL)
            return (player, image)
        } else {
            return (player, nil)
        }
    }

    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather {
        let player = try await playersRepository.getCurrentPlayer()
        let country = player.country
        return try await nearestCourtWithWeatherUseCase.getNearestCourtWithWeather(for: country.apiValue)
    }
}
#endif
