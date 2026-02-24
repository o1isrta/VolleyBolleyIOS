//
//  NetworkError.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

enum NetworkError: Error {
	case unauthorized
	case network
	case tooManyRequests
	case decodingFailed
	case cannotFindHost
	case networkConnectionLost
	case client
	case server
	case unknown

	var localizedDescription: String {
		switch self {
		case .unauthorized:
			return String(localized: "networkError.unauthorized", table: "Errors")
		case .network:
			return String(localized: "networkError.network", table: "Errors")
		case .tooManyRequests:
			return String(localized: "networkError.tooManyRequests", table: "Errors")
		case .decodingFailed:
			return String(localized: "networkError.decodingFailed", table: "Errors")
		case .cannotFindHost:
			return String(localized: "networkError.cannotFindHost", table: "Errors")
		case .networkConnectionLost:
			return String(localized: "networkError.networkConnectionLost", table: "Errors")
		case .client:
			return String(localized: "networkError.client", table: "Errors")
		case .server:
			return String(localized: "networkError.server", table: "Errors")
		case .unknown:
			return String(localized: "networkError.unknown", table: "Errors")
		}
	}
}
