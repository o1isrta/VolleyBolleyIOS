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

    static func localized(_ fullKey: String) -> String {
        let parts = fullKey.split(separator: ".", maxSplits: 1)

        guard parts.count == 2 else {
            return NSLocalizedString(fullKey, comment: "")
        }

        let table = String(parts[0])
        let key = String(parts[1])
        return NSLocalizedString(
            key,
            tableName: table,
            bundle: .main,
            value: "",
            comment: ""
        )
    }
}
