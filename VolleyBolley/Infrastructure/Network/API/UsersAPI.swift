//
//  UsersAPI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation
import Moya

struct NetworkEnvironment {
    static var current: AppEnvironment = .production
}

enum UsersAPI {
    case getCurrentUser
}

extension UsersAPI: TargetType {
    var baseURL: URL {
        return NetworkEnvironment.current.baseURL
    }

    var path: String {
        switch self {
        case .getCurrentUser:
            return "/users/me"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCurrentUser:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getCurrentUser:
            return .requestPlain
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
        case .getCurrentUser:
            guard
                let url = Bundle.main.url(
                    forResource: "get_current_user_sample",
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
