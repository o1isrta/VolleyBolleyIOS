//
//  NetworkError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.09.2025.
//

import Foundation

enum NetworkError: Error {
    case unauthorized
    case serverError(Int)
    case decodingFailed
    case network(Error)
    case unknown
}
