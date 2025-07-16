//
//  UsersAPI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation
import Moya

enum UsersAPI {
    case getCurrentUser
}

extension UsersAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://e398050f-d75c-48f1-bb6c-28db405375f2.mock.pstmn.io")!
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
            return """
            {
                "id": 1,
                "name": "Mock User",
                "date_of_birth": "1990-01-01",
                "avatar_url": "https://example.com/avatar.png"
            }
            """.data(using: .utf8)!
        }
    }
}
