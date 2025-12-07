//
//  L10n+Errors.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.11.2025.
//

import Foundation

extension L10n {
    enum Errors {
        static var fallback: String { Errors.localized("fallback") }
        static var network: String { Errors.localized("network") }
        static var missingToken: String { Errors.localized("missing_token") }
        static var signInCancelled: String { Errors.localized("signIn_cancelled") }
        static var signInFailed: String { Errors.localized("signIn_failed") }
        static var invalidCredentials: String {Errors.localized("invalid_credentials") }
        static var userDisabled: String { Errors.localized("user_disabled") }
        static var tooManyRequests: String { Errors.localized("too_many_requests") }
        static var invalidPhone: String { Errors.localized("invalid_phone") }
        static var quotaExceeded: String { Errors.localized("quota_exceeded") }
        static var invalidCode: String { Errors.localized("invalid_code") }
        static var sessionExpired: String { Errors.localized("session_expired") }
        static var phoneNumberIsTooShort: String { Errors.localized("phone_number_too_short") }
        static var notImplemented: String { Errors.localized("not_implemented") }


        enum StayInLoop {
            static var title: String { Errors.localized("stay_in_loop.title") }
            static var item1: String { Errors.localized("stay_in_loop.item1") }
            static var item2: String { Errors.localized("stay_in_loop.item2") }
            static var item3: String { Errors.localized("stay_in_loop.item3") }
        }

        private static let tableName = "Errors"

        static func localized(_ key: String) -> String {
            L10n.localized(key, table: tableName)
        }
    }
}
