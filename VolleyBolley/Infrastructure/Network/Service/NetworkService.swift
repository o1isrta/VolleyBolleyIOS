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
		provider: MoyaProvider<DataAPI>,
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

    func fetchCourts() async throws -> [CourtDTO] {
        do {
            return try await provider.asyncRequestDecodable(
                .getCourts,
                type: [CourtDTO].self,
                decoder: AppJSONDecoders.server
            )
        } catch let error as MoyaError {
            throw error.toNetworkError()
        }
    }

	/// Google Auth (POST, without auth)
	func googleAuth(
		code: String,
		completion: @escaping (Result<GoogleAuthResponse, Error>) -> Void
	) {
		request(.googleAuth(code: code), completion: completion)
	}

	/// Get  Country List (GET, without auth)
	func getCountryList(completion: @escaping (Result<CountryListResponse, Error>) -> Void) {
		request(.getCountryList, completion: completion)
	}

    // TODO: - refactor
//	/// Search Courts (GET, with auth)
//	func searchCourts(
//		query: String,
//		completion: @escaping (Result<Court, Error>) -> Void
//	) {
//		guardToken { [weak self] in
//			self?.request(.searchCourts(query: query), completion: completion)
//		}
//	}

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
						let error = NetworkError.invalidStatusCode(response.statusCode)
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
						let error = NetworkError.invalidStatusCode(response.statusCode)
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
