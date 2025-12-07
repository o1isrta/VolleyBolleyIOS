//
//  L10n.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.11.2025.
//

import Foundation

enum L10n {
    static func localized(_ key: String, table: String? = nil) -> String {
        NSLocalizedString(
            key,
            tableName: table,
            bundle: .main,
            value: "",
            comment: ""
        )
    }
}
