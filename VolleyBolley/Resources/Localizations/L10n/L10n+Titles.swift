//
//  L10n+Titles.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

extension L10n {
    enum Titles {
        static var error: String { Titles.localized("alert.error") }
        static var warning: String { Titles.localized("alert.warning") }
        static var notifications: String { Titles.localized("alert.notifications") }

        private static let tableName = "Titles"

        static func localized(_ key: String) -> String {
            L10n.localized(key, table: tableName)
        }
    }
}
