//
//  AppEnvironment.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.07.2025.
//

import Foundation

enum AppEnvironment: String {
    case mock = "mock"
    case staging = "staging"
    case production = "production"

    var baseURL: URL {
        switch self {
        case .mock:
            return AppEnvironment.makeURL("https://sample.local")
        case .staging:
            return AppEnvironment.makeURL("https://e398050f-d75c-48f1-bb6c-28db405375f2.mock.pstmn.io")
        case .production:
            // TODO: - Add production url
            return AppEnvironment.makeURL("https://api.domain.com")
        }
    }

    var useStubbedProvider: Bool {
        return self == .mock
    }

    static func fromPlist() -> AppEnvironment {
        guard let envString = Bundle.main.object(forInfoDictionaryKey: "APP_ENV") as? String,
              let env = AppEnvironment(rawValue: envString) else {
            return .production
        }
        return env
    }

    private static func makeURL(_ urlString: String) -> URL {
        guard let url = URL(string: urlString) else {
            fatalError("Error: Invalid URL string: \(urlString)")
        }
        return url
    }
}
