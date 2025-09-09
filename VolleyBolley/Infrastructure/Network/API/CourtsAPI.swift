//
//  CourtsAPI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

import Foundation
import Moya

enum CourtsAPI {
    case getCourts(country: String)
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
        case .getCourts(let country):

            return .requestParameters(
                parameters: ["country": country],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        switch self {
        case .getCourts(let country):
            let fileName: String
            switch country.lowercased() {
            case "thailand":
                fileName = "get_courts_thailand_sample"
            case "cyprus":
                fileName = "get_courts_cyprus_sample"
            default:
                fileName = "get_courts_thailand_sample" // fallback
            }

            guard
                let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        }
    }
}
