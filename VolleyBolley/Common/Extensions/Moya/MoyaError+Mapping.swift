//
//  MoyaError+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.09.2025.
//

import Moya

extension MoyaError {

    func toNetworkError() -> NetworkError {
        switch self {
        case .statusCode(let response):
            if response.statusCode == 401 {
                return .unauthorized
            } else {
                return .serverError(response.statusCode)
            }
        case .objectMapping:
            return .decodingFailed
        case .underlying(let underlying, _):
            return .network(underlying)
        default:
            return .unknown
        }
    }
}
