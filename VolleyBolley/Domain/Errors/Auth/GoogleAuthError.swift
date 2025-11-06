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
            return "Connection problem. Please check your internet."
        case .missingIDToken:
            return "Failed to verify Google credentials."
        case .signInCancelled:
            return "Sign-in was cancelled."
        case .signInFailed(let error):
            return error
        case .unknown(let error):
            print("❌ GoogleAuth internal error: \(error)")
            return "Something went wrong. Please try again."
        }
    }
}
