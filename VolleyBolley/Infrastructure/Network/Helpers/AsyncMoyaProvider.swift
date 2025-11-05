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
                    do {
                        try self.validate(response)
                        continuation.resume(returning: response)
                    } catch {
                        print("Validation error: \(error)")
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    let networkError = error.toNetworkError()
                    print("Network error: \(networkError)")
                    continuation.resume(throwing: networkError)
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

        guard !response.data.isEmpty else {
            print("Decoding failed: empty response")
            throw NetworkError.decodingFailed
        }

        do {
            return try decoder.decode(T.self, from: response.data)
        } catch {
            print("Decoding failed: \(error)")
            throw NetworkError.decodingFailed
        }
    }

    func asyncRequestVoid(_ target: Target) async throws {
        _ = try await asyncRequestResponse(target)
    }

    // MARK: - Private

    private func validate(_ response: Response) throws {
        switch response.statusCode {
        case 200..<300:
            return
        case 401:
            print("Unauthorized")
            throw NetworkError.unauthorized
        case 400..<500:
            let message = response.errorMessage
            print("Client error \(response.statusCode): \(message ?? "no message")")
            throw NetworkError.clientError(response.statusCode, message)
        case 500..<600:
            let message = response.errorMessage
            print("Server error \(response.statusCode): \(message ?? "no message")")
            throw NetworkError.serverError(response.statusCode)
        default:
            print("Invalid status code: \(response.statusCode)")
            throw NetworkError.invalidStatusCode(response.statusCode)
        }
    }
}
