//
//  GamesAPI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 13.09.2025.
//

import Foundation
import Moya

enum GamesAPI {
    case getUpcomingGames
    case getArchivedGames
}

extension GamesAPI: TargetType {

    // NOTE: baseURL is unused, actual value is overridden in MoyaProvider's endpointClosure
    var baseURL: URL {
        preconditionFailure("baseURL must not be used directly; it's overridden in endpointClosure")
    }

    var path: String {
        switch self {
        case .getUpcomingGames:
            return "/games/upcoming"
        case .getArchivedGames:
            return "/games/archive"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUpcomingGames, .getArchivedGames:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getUpcomingGames, .getArchivedGames:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

// MARK: - Mock data

#if DEBUG
extension GamesAPI {

    var sampleData: Data {
        switch self {
        case .getUpcomingGames:
            guard
                let url = Bundle.main.url(
                    forResource: "get_games_upcoming_sample",
                    withExtension: "json"
                ),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }

            return data
        case .getArchivedGames:
            guard
                let url = Bundle.main.url(
                    forResource: "get_games_archive_sample",
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
