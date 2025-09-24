//
//  NetworkError.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

enum NetworkError: Error {
    case unauthorized
    case clientError(Int, String?)
    case serverError(Int)
    case invalidStatusCode(Int)
    case decodingFailed
    case noInternet
    case timeout
    case serverUnreachable
    case cancelled
    case network(Error)
    case unknown
}
