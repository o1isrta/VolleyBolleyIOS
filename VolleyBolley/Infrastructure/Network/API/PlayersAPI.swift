//
//  PlayersAPI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation
import Moya

enum PlayersAPI {
    case getCurrentPlayer
}

extension PlayersAPI: TargetType {

    // NOTE: baseURL is unused, actual value is overridden in MoyaProvider's endpointClosure
    var baseURL: URL {
        preconditionFailure("baseURL must not be used directly; it's overridden in endpointClosure")
    }

    var path: String {
        switch self {
        case .getCurrentPlayer:
            return "/players/me"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCurrentPlayer:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getCurrentPlayer:
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
        case .getCurrentPlayer:
            guard
                let url = Bundle.main.url(
                    forResource: "get_current_player_sample",
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
