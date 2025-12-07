//
//  L10n+Buttons.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Foundation

extension L10n {
    enum Buttons {
        static var okay: String { Buttons.localized("ok") }
        static var retry: String { Buttons.localized("retry") }
        static var skip: String { Buttons.localized("skip") }
        static var enable: String { Buttons.localized("enable") }

        // TODO: - debug
        static var mainApp: String { Buttons.localized("mainApp") }

        private static let tableName = "Buttons"

        static func localized(_ key: String) -> String {
            L10n.localized(key, table: tableName)
        }
    }
}
