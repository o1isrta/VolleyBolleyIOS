//
//  FirebaseAuthError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 06.11.2025.
//

import Foundation

enum FirebaseAuthError: LocalizedError {

    case networkError
    case invalidCredentials
    case userDisabled
    case tooManyRequests
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .networkError:
            return String(localized: .errorMessageNetwork)
        case .invalidCredentials:
            return String(localized: .errorMessageInvalidCredentials)
        case .userDisabled:
            return String(localized: .errorMessageUserDisabled)
        case .tooManyRequests:
            return String(localized: .errorMessageTooManyRequests)
        case .unknown(let error):
            print("❌ FirebaseAuth internal error: \(error)")
            return String(localized: .errorMessageFallback)
        }
    }
}
