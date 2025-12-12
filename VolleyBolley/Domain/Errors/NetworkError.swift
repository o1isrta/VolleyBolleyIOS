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
}
