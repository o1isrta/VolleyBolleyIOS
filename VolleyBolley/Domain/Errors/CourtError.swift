//
//  CourtError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.09.2025.
//

import Foundation

enum CourtError: Error {
    case notFound
    case serviceFailed
    case unknown(Error)
}

extension CourtError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "No courts found."
        case .serviceFailed:
            return "Courts service is unavailable."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
