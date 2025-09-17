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
}

// MARK: - Mock data

#if DEBUG
extension PlayersAPI {

    /// Provides mock response data for the PlayersAPI in DEBUG builds.
    ///
    /// This property supplies sample JSON payloads to Moya when running in a debug configuration,
    /// enabling UI development and testing without hitting the real backend.
    /// - Behavior:
    ///   - For the `.getCurrentPlayer` endpoint, it attempts to load a JSON file named
    ///     "get_current_player_sample.json" from the main bundle.
    ///   - If the file cannot be found or read, it returns empty `Data()`, which will typically
    ///     cause decoding to fail—surfacing missing or malformed mock assets during development.
    /// - Notes:
    ///   - Ensure the "get_current_player_sample.json" file is included in the app target’s bundle
    ///     resources for DEBUG builds.
    ///   - This property is compiled only when `#if DEBUG` is active; it is not present in release builds.
    /// - Returns: The contents of the mock JSON file as `Data`, or empty data if loading fails.
    var sampleData: Data {
        switch self {
        case .getCurrentPlayer:
            guard
                let url = Bundle.main.url(
                    forResource: "get_player_me_sample",
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
