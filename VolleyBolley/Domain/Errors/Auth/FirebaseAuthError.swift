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
            return "Connection problem. Please check your internet."
        case .invalidCredentials:
            return "Failed to verify Google credentials."
        case .userDisabled:
            return "This account has been disabled."
        case .tooManyRequests:
            return "Too many attempts. Please try again later."
        case .unknown(let error):
            print("❌ FirebaseAuth internal error: \(error)")
            return "Something went wrong. Please try again."
        }
    }
}
