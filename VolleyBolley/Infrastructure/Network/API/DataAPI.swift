//
//  DataAPI.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation
import Moya

enum DataAPI {
    case googleAuth(idToken: String)
    case getCountryList
    case getCurrentUser
    case searchCourts(query: String)
    case invitePlayers(gameID: Int, playerIDs: [Int])
    case updateAvatar(avatar: String?)
    case updatePlayerProfile(with: PlayerDTO)
    case deletePlayer
}

extension DataAPI: TargetType {

    // NOTE: baseURL is unused, actual value is overridden in MoyaProvider's endpointClosure
    var baseURL: URL {
        preconditionFailure("baseURL must not be used directly; it's overridden in endpointClosure")
    }

    var path: String {
        switch self {
        case .googleAuth:
            return "/auth/google/login/v2/"
        case .getCountryList:
            return "/countries/"
        case .getCurrentUser:
            return "/users/me"
        case .searchCourts:
            return "/courts/"
        case .updateAvatar:
            return "/players/me/avatar"
        case .updatePlayerProfile:
            return "/players/me"
        case .invitePlayers(let gameID, _):
            return "/games/\(gameID)/invite-players"
        case .deletePlayer:
            return "/players/me"
        }
    }

    var method: Moya.Method {
        switch self {
        case .googleAuth, .invitePlayers:
            return .post
        case .getCurrentUser, .searchCourts:
            return .get
        case .getCountryList, .updateAvatar:
            return .put
        case .updatePlayerProfile:
            return .patch
        case .deletePlayer:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .googleAuth(let idToken):
            let parameters = ["id_token": idToken]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .searchCourts(let query):
            return .requestParameters(parameters: ["search": query], encoding: URLEncoding.queryString)
        case .invitePlayers(_, let playerIDs):
            return .requestJSONEncodable(InvitePlayersRequest(playerIDs: playerIDs))
        case .updateAvatar(let avatar):
            let parameters: [String: Any] = [
                "avatar": avatar as Any // nil becomes NSNull() → null in JSON
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .updatePlayerProfile(let request):
            return .requestJSONEncodable(request)
        case .getCountryList, .getCurrentUser, .deletePlayer:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getCurrentUser, .searchCourts,
                .invitePlayers, .updateAvatar, .updatePlayerProfile, .deletePlayer:
            var headers: [String: String] = [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]

            if needsAuthorization, let token = DataAPI.tokenProvider?() {
                headers["Authorization"] = "Bearer \(token)"
            }

            return headers
        case .googleAuth, .getCountryList:
            return ["Content-Type": "application/json"]
        }
    }

    // MARK: - Private Logic

    private var needsAuthorization: Bool {
        switch self {
        case .googleAuth, .getCountryList:
            return false
        default:
            return true
        }
    }

    // External dependency for token (injected via Swinject)
    static var tokenProvider: (() -> String?)?
}
