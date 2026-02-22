//
//  AsyncMoyaProvider.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation
import Moya

extension MoyaProvider {

	func asyncRequestResponse(_ target: Target) async throws -> Response {
		try await withCheckedThrowingContinuation { continuation in
			self.request(target) { result in
				switch result {
				case .success(let response):
					continuation.resume(returning: response)

				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}

	func asyncRequestDecodable<T: Decodable>(
		_ target: Target,
		type: T.Type,
		decoder: JSONDecoder = JSONDecoder()
	) async throws -> T {
		let response = try await asyncRequestResponse(target)

		do {
			return try decoder.decode(T.self, from: response.data)
		} catch {
			throw MoyaError.objectMapping(error, response)
		}
	}

	func asyncRequestVoid(_ target: Target) async throws {
		_ = try await asyncRequestResponse(target)
	}
}
