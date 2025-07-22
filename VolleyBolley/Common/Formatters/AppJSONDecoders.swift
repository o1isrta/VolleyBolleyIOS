//
//  AppJSONDecoders.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 22.07.2025.
//

import Foundation

enum AppJSONDecoders {
    /// Декодер для работы с API (snake_case + ISO8601 даты)
    static let server: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(AppDateFormatters.serverDateOnly)
        return decoder
    }()
}
