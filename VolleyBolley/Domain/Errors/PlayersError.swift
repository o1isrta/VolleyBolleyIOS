//
//  PlayersError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

enum PlayersError: Error {
    case notFound
    case unauthorized
    case decodingFailed
    case serverError(Int)
    case network(Error)
    case unknown
}

extension PlayersError {
    static func from(_ error: NetworkError) -> PlayersError {
        switch error {
        case .unauthorized:
            return .unauthorized
        case .serverError(let code):
            if code == 404 {
                return .notFound
            }
            return .serverError(code)
        case .decodingFailed:
            return .decodingFailed
        case .network(let underlying):
            return .network(underlying)
        case .unknown:
            return .unknown
        }
    }
}
