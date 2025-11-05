//
//  MoyaError+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation
import Moya

extension MoyaError {

    func toNetworkError() -> NetworkError {
        switch self {
        case .statusCode(let response):
            return mapStatusCode(response)

        case .underlying(let error, _):
            return mapUnderlying(error)

        case .objectMapping, .encodableMapping, .parameterEncoding:
            print("❌ Decoding / Encoding failed: \(self)")
            return .decodingFailed

        default:
            print("⚠️ Unknown MoyaError: \(self)")
            return .unknown
        }
    }

    // MARK: - Private helpers

    private func mapStatusCode(_ response: Response) -> NetworkError {
        switch response.statusCode {
        case 401:
            print("❌ Unauthorized (401)")
            return .unauthorized
        case 400..<500:
            print("❌ Client error: \(response.statusCode)")
            return .clientError(response.statusCode, response.errorMessage)
        case 500..<600:
            print("❌ Server error: \(response.statusCode)")
            return .serverError(response.statusCode)
        default:
            print("❌ Invalid status code: \(response.statusCode)")
            return .invalidStatusCode(response.statusCode)
        }
    }

    private func mapUnderlying(_ error: Error) -> NetworkError {
        guard let urlError = error as? URLError else {
            print("❌ Underlying non-URLError: \(error.localizedDescription)")
            return .network(error)
        }

        switch urlError.code {
        case .notConnectedToInternet:
            print("❌ No Internet")
            return .noInternet
        case .timedOut:
            print("❌ Timeout")
            return .timeout
        case .cannotFindHost, .cannotConnectToHost:
            print("❌ Server unreachable")
            return .serverUnreachable
        case .cancelled:
            print("❌ Request cancelled")
            return .cancelled
        default:
            print("❌ Other URLError: \(urlError)")
            return .network(urlError)
        }
    }
}
