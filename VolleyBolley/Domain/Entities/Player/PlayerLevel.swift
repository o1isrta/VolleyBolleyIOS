//
//  PlayerLevel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.07.2025.
//

import Foundation

enum PlayerLevel: CaseIterable, Codable {
    case light, medium, hard, pro, unknown

    static var allCases: [PlayerLevel] {
        return [.light, .medium, .hard, .pro, .unknown]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = (try? container.decode(String.self))?.uppercased() ?? ""

        switch rawValue {
        case "LIGHT": self = .light
        case "MEDIUM": self = .medium
        case "HARD": self = .hard
        case "PRO": self = .pro
        default: self = .unknown
        }
    }
}

extension PlayerLevel {

    init(fromServer string: String) {
        switch string.uppercased() {
        case "LIGHT": self = .light
        case "MEDIUM": self = .medium
        case "HARD": self = .hard
        case "PRO": self = .pro
        default: self = .unknown
        }
    }
}
