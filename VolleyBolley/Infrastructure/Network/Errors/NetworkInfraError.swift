//
//  NetworkInfraError.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

enum NetworkInfraError: Error {
    case missingAccessToken
    case invalidStatusCode(Int)

    var description: String {
        switch self {
        case .missingAccessToken:
            return "Access token not found"
        case .invalidStatusCode(let code):
            return "The server returned a failed status: \(code)"
        }
    }
}
