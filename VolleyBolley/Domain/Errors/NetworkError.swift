//
//  NetworkError.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

enum NetworkError: Error {
    case unauthorized
    case serverError(Int)
    case decodingFailed
    case network(Error)
    case unknown
	case missingAccessToken
	case invalidStatusCode(Int)

//	var description: String {
//		switch self {
//		case .missingAccessToken:
//			return "Access token not found"
//		case .invalidStatusCode(let code):
//			return "The server returned a failed status: \(code)"
//		}
//	}
}
