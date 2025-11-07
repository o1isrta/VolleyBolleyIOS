//
//  GoogleAuthError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

enum GoogleAuthError: LocalizedError {

    case networkError
    case missingIDToken
    case signInCancelled
    case signInFailed(String)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .networkError:
            return String(localized: .errorMessageNetwork)
        case .missingIDToken:
            return String(localized: .errorMessageMissingIDToken)
        case .signInCancelled:
            return String(localized: .errorMessageSignInCancelled)
        case .signInFailed(let error):
            print("❌ GoogleAuth internal error: \(error)")
            return String(localized: .errorMessageFallback)
        case .unknown(let error):
            print("❌ GoogleAuth internal error: \(error)")
            return String(localized: .errorMessageFallback)
        }
    }
}
