//
//  TabBarItem.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 14.07.2025.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case games
    case profile

    var title: String {
        switch self {
        case .home: return String(localized: "Home", comment: "Tab bar item title")
        case .games: return String(localized: "My games", comment: "Tab bar item title")
        case .profile: return String(localized: "Profile", comment: "Tab bar item title")
        }
    }

    var icon: UIImage? {
        switch self {
        case .home: return .Icon.home
        case .games: return .Icon.volleyball
        case .profile: return .Icon.person
        }
    }
}
