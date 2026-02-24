//
//  AuthError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.11.2025.
//

import Foundation

enum AuthError: Error {
	case invalidPhoneNumber
	case missingPhoneNumber
	case invalidVerificationCode
	case sessionExpired
	case networkError
	case tooManyRequests
	case quotaExceeded
	case userDisabled
	case verificationFailed
	case unknown
	case invalidCredentials
	case missingIDToken
	case signInCancelled
	case signInFailed
	case keychainError
	case noAuthInKeychain
	case mismatchWithCurrentUser
	case scopesAlreadyGranted
	case emm

	var localizedDescription: String {
		switch self {
		case .invalidPhoneNumber:
			return String(localized: "authError.invalidPhoneNumber", table: "Errors")
		case .missingPhoneNumber:
			return String(localized: "authError.missingPhoneNumber", table: "Errors")
		case .invalidVerificationCode:
			return String(localized: "authError.invalidVerificationCode", table: "Errors")
		case .sessionExpired:
			return String(localized: "authError.sessionExpired", table: "Errors")
		case .networkError:
			return String(localized: "authError.networkError", table: "Errors")
		case .tooManyRequests:
			return String(localized: "authError.tooManyRequests", table: "Errors")
		case .quotaExceeded:
			return String(localized: "authError.tooManyRequests", table: "Errors")
		case .userDisabled:
			return String(localized: "authError.userDisabled", table: "Errors")
		case .verificationFailed:
			return String(localized: "authError.verificationFailed", table: "Errors")
		case .unknown:
			return String(localized: "authError.unknown", table: "Errors")
		case .invalidCredentials:
			return String(localized: "authError.invalidCredentials", table: "Errors")
		case .missingIDToken:
			return String(localized: "authError.missingIDToken", table: "Errors")
		case .signInCancelled:
			return String(localized: "authError.signInCancelled", table: "Errors")
		case .signInFailed:
			return String(localized: "authError.signInFailed", table: "Errors")
		case .keychainError:
			return String(localized: "authError.keychainError", table: "Errors")
		case .noAuthInKeychain:
			return String(localized: "authError.noAuthInKeychain", table: "Errors")
		case .mismatchWithCurrentUser:
			return String(localized: "authError.mismatchWithCurrentUser", table: "Errors")
		case .scopesAlreadyGranted:
			return String(localized: "authError.scopesAlreadyGranted", table: "Errors")
		case .emm:
			return String(localized: "authError.emm", table: "Errors")
		}
	}
}
