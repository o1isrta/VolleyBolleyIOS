//
//  CourtsAPI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation
import Moya

enum CourtsAPI {
    case getCourts
}

extension CourtsAPI: TargetType {

    // NOTE: baseURL is unused, actual value is overridden in MoyaProvider's endpointClosure
    var baseURL: URL {
        preconditionFailure("baseURL must not be used directly; it's overridden in endpointClosure")
    }

    var path: String {
        switch self {
        case .getCourts:
            return "/courts"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCourts:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getCourts:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

// MARK: - Mock data

#if DEBUG
extension CourtsAPI {

    var sampleData: Data {
        switch self {
        case .getCourts:
            guard
                let url = Bundle.main.url(
                    forResource: "get_courts_sample",
                    withExtension: "json"
                ),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }

            return data
        }
    }
}
#endif
