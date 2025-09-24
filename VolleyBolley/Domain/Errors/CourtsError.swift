//
//  CourtsError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.09.2025.
//

import Foundation

enum CourtsError: Error {
    case notFound
    case unauthorized
    case decodingFailed
    case serverError(Int)
    case offline
    case timeout
    case cancelled
    case network(Error)
    case unknown
}

extension CourtsError {
    static func from(_ error: NetworkError) -> CourtsError {
        switch error {
        case .unauthorized: return .unauthorized
        case .clientError(let code, _): return mapClientError(code)
        case .serverError(let code): return .serverError(code)
        case .decodingFailed: return .decodingFailed
        case .noInternet: return .offline
        case .timeout: return .timeout
        case .cancelled: return .cancelled
        case .network(let underlying): return .network(underlying)
        case .invalidStatusCode(let code): return .serverError(code)
        case .unknown, .serverUnreachable: return .unknown
        }
    }

    private static func mapClientError(_ code: Int) -> CourtsError {
        if code == 404 {
            return .notFound
        }

        return .serverError(code)
    }
}
