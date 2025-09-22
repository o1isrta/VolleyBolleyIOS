//
//  Country.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.09.2025.
//

import Foundation

enum Country: Int, Codable {
    case thailand = 1
    case cyprus = 2
    case unknown

    var apiValue: String {
        switch self {
        case .thailand: return "thailand"
        case .cyprus: return "cyprus"
        case .unknown: return ""
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try? container.decode(Int.self)
        self = Country(rawValue: rawValue ?? -1) ?? .unknown
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}
