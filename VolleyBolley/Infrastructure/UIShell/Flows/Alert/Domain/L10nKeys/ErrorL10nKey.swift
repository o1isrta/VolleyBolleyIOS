//
//  ErrorL10nKey.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 10.12.2025.
//

enum ErrorL10nKey: String {
    case fallback = "Errors.fallback"
    case network = "Errors.network"
    case missingToken = "Errors.missing_token"
    case signInCancelled = "Errors.signIn_cancelled"
    case signInFailed = "Errors.signIn_failed"
    case invalidCredentials = "Errors.invalid_credentials"
    case userDisabled = "Errors.user_disabled"
    case tooManyRequests = "Errors.too_many_requests"
    case invalidPhone = "Errors.invalid_phone"
    case quotaExceeded = "Errors.quota_exceeded"
    case invalidCode = "Errors.invalid_code"
    case sessionExpired = "Errors.session_expired"
    case phoneNumberIsTooShort = "Errors.phone_number_too_short"
    case notImplemented = "Errors.not_implemented"

    case notificationDisabled = "Errors.notification_disabled"
    case notificationDisabledItem1 = "Errors.notification_disabled.item1"
    case notificationDisabledItem2 = "Errors.notification_disabled.item2"
    case notificationDisabledItem3 = "Errors.notification_disabled.item3"
}
