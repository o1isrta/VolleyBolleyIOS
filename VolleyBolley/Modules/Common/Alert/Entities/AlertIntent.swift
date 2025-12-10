//
//  AlertIntent.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 08.12.2025.
//

enum AlertIntent {
    case dismiss
    case retry
    case relogin
    case openSettings
    case openMainApp
    case custom(id: AlertCustomActionID)
}

struct AlertCustomActionID: Equatable, Hashable {
    let rawValue: String
}
