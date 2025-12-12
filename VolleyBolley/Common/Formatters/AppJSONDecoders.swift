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
        decoder.dateDecodingStrategy = .formatted(AppDateFormatters.serverDateOnly)
        return decoder
    }()
}
