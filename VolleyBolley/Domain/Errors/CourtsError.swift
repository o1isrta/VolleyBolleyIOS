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
    case network(Error)
    case unknown
}

extension CourtsError {
    static func from(_ error: NetworkError) -> CourtsError {
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
