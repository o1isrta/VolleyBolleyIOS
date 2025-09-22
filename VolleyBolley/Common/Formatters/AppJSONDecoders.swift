//
//  AppJSONDecoders.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 22.07.2025.
//

import Foundation

enum AppJSONDecoders {

    static let server: JSONDecoder = {
        let decoder = JSONDecoder()

        decoder.dateDecodingStrategy = .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            if let date = AppDateFormatters.apiDateOnly.date(from: dateStr) {
                return date
            }

            if let date = AppDateFormatters.serverDateOnly.date(from: dateStr) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date format: \(dateStr)"
            )
        }

        return decoder
    }()
}
