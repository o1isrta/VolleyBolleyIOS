//
//  NetworkService.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation
import Moya

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Private Properties

    private let provider: MoyaProvider<DataAPI>
    private let tokenProvider: () -> String?

    // MARK: - Initializers

    init(
        provider: MoyaProvider<DataAPI> = MoyaProvider<DataAPI>(),
        tokenProvider: @escaping () -> String?
    ) {
        self.provider = provider
        self.tokenProvider = tokenProvider

        DataAPI.tokenProvider = tokenProvider
    }

    deinit {
        // Cleaning to avoid retain cycle
        DataAPI.tokenProvider = nil
    }

    // MARK: - Public Methods

    func googleAuth(idToken: String) async throws -> PlayerSessionDTO {
        try await performRequest(
            .googleAuth(idToken: idToken),
            type: PlayerSessionDTO.self,
            decoder: AppJSONDecoders.server
        )
    }

    /// Get  Country List (GET, without auth)
    func getCountryList(completion: @escaping (Result<CountryListResponse, Error>) -> Void) {
        request(.getCountryList, completion: completion)
    }

    /// Search Courts (GET, with auth)
    func searchCourts(
        query: String,
        completion: @escaping (Result<CourtSearchResponse, Error>) -> Void
    ) {
        guardToken { [weak self] in
            self?.request(.searchCourts(query: query), completion: completion)
        }
    }

    /// Invite Players (POST, with auth)
    func invitePlayers(
        gameID: Int,
        playerIDs: [Int],
        completion: @escaping (Result<InvitePlayersResponse, Error>) -> Void
    ) {
        guardToken { [weak self] in
            self?.request(.invitePlayers(gameID: gameID, playerIDs: playerIDs), completion: completion)
        }
    }

    /// Update avatar (PUT, with auth)
    func updateAvatar(
        avatar: String?,
        completion: @escaping (Result<UpdateAvatarResponse, Error>) -> Void
    ) {
        guardToken { [weak self] in
            self?.request(.updateAvatar(avatar: avatar), completion: completion)
        }
    }

    /// Update Player Profile with new data (PUT, with auth)
    func updatePlayerProfile(
        with newData: PlayerDTO,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guardToken { [weak self] in
            self?.provider.request(.updatePlayerProfile(with: newData)) { result in
                switch result {
                case .success(let response):
                    if (200...299).contains(response.statusCode) {
                        DispatchQueue.main.async {
                            completion(.success(()))
                        }
                    } else {
                        let error = NetworkInfraError.invalidStatusCode(response.statusCode)
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    /// Delete Player (DELETE, with auth)
    func deletePlayer(completion: @escaping (Result<Void, Error>) -> Void) {
        guardToken { [weak self] in
            self?.provider.request(.deletePlayer) { result in
                switch result {
                case .success(let response):
                    if (200...299).contains(response.statusCode) {
                        DispatchQueue.main.async {
                            completion(.success(()))
                        }
                    } else {
                        let error = NetworkInfraError.invalidStatusCode(response.statusCode)
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}

// MARK: - Private Methods

private extension NetworkService {

    // TODO: - add logger
    private func performRequest<T>(
        _ request: DataAPI,
        type: T.Type,
        decoder: JSONDecoder
    ) async throws -> T where T: Decodable {
        do {
            return try await provider.asyncRequestDecodable(request, type: type, decoder: decoder)
        } catch let moyaError as MoyaError {
            print("❌ NetworkService.performRequest error: \(moyaError)")
            throw mapMoyaToDomain(moyaError)
        } catch {
            print("❌ NetworkService.performRequest error: \(error)")
            throw DomainError.unknown
        }
    }

    private func mapMoyaToDomain(_ error: MoyaError) -> DomainError {
        switch error {
        case .statusCode(let response):
            return mapStatusCode(response)
        case .underlying(let urlError, _):
            return mapUnderlying(urlError)
        case .objectMapping:
            return .network(.decodingFailed)
        default:
            return .network(.unknown)
        }
    }

    private func mapStatusCode(_ response: Response) -> DomainError {
        switch response.statusCode {
        case 401:
            return .network(.unauthorized)
        case 429:
            return .network(.tooManyRequests)
        case 400..<500:
            return .network(.client)
        case 500..<600:
            return .network(.server)
        default:
            return .network(.network)
        }
    }

    private func mapUnderlying(_ error: Error) -> DomainError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut, .notConnectedToInternet:
                return .network(.network)
            case .cannotFindHost:
                return .network(.cannotFindHost)
            case .networkConnectionLost:
                return .network(.networkConnectionLost)
            default:
                return .network(.unknown)
            }
        }
        return .network(.unknown)
    }

    private func guardToken(then execute: () -> Void) {
        guard tokenProvider() != nil else {
            // let error = NetworkError.missingAccessToken
            // Here completion is not passed, so we need to wrap the calls above in Result.failure
            // But we use request(), where completion is already there - so we just don't call execute
            return
        }
        execute()
    }

    private func request<T: Decodable>(
        _ target: DataAPI,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                print("RESPONSE:", response.data)// TODO:
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: response.data)
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let moyaError):
                print("ERROR: \(moyaError)")// TODO:
                DispatchQueue.main.async {
                    completion(.failure(moyaError))
                }
            }
        }
    }
}
