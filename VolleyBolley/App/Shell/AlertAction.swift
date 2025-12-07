//
//  AlertAction.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Foundation

enum AlertAction {
    case dismiss(
        title: String,
        isPrimary: Bool = false,
        maxWidthFraction: CGFloat? = nil
    )
    case retry(
        title: String,
        isPrimary: Bool = true,
        maxWidthFraction: CGFloat? = nil
    )
    case relogin(
        title: String,
        isPrimary: Bool = true,
        maxWidthFraction: CGFloat? = nil
    )
    case openSettings(
        title: String,
        isPrimary: Bool = true,
        maxWidthFraction: CGFloat? = nil
    )
    case openMainApp(
        title: String,
        isPrimary: Bool = true,
        maxWidthFraction: CGFloat? = nil
    )
    case custom(
        title: String,
        isPrimary: Bool,
        maxWidthFraction: CGFloat? = nil,
        handler: () -> Void
    )

    var title: String {
        switch self {
        case .dismiss(let title, _, _): return title
        case .retry(let title, _, _): return title
        case .relogin(let title, _, _): return title
        case .openSettings(let title, _, _): return title
        case .openMainApp(let title, _, _): return title
        case .custom(let title, _, _, _): return title
        }
    }

    var isPrimary: Bool {
        switch self {
        case .dismiss(_, let isPrimary, _),
                .retry(_, let isPrimary, _),
                .relogin(_, let isPrimary, _),
                .openSettings(_, let isPrimary, _),
                .openMainApp(_, let isPrimary, _),
                .custom(_, let isPrimary, _, _):
            return isPrimary
        }
    }

    var maxWidthFraction: CGFloat? {
        switch self {
        case .dismiss(_, _, let maxWidthFraction),
                .retry(_, _, let maxWidthFraction),
                .relogin(_, _, let maxWidthFraction),
                .openSettings(_, _, let maxWidthFraction),
                .openMainApp(_, _, let maxWidthFraction),
                .custom(_, _, let maxWidthFraction, _):
            return maxWidthFraction
        }
    }
}
