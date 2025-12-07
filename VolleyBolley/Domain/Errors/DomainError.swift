//
//  DomainError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.11.2025.
//

import Foundation

enum DomainError: Error {
    case auth(AuthError)
    case network(NetworkError)
    case common(CommonError)
    case unknown
}
