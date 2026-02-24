//
//  DomainError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.11.2025.
//

import Foundation

enum DomainError: Error, LocalizedError {
	case auth(AuthError)
	case network(NetworkError)
	case unknown

	var errorDescription: String? {
		switch self {
		case .auth(let authError):
			return authError.localizedDescription
		case .network(let networkError):
			return networkError.localizedDescription
		case .unknown:
			return String(localized: "domainError.unknown", table: "Errors")
		}
	}
}
