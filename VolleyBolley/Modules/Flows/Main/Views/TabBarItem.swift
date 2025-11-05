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
        case .home: return String(localized: "common.home")
        case .games: return String(localized: "common.myGames")
        case .profile: return String(localized: "common.profile")
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
