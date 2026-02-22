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
}
