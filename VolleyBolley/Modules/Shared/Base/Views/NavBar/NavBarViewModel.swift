//
//  NavBarViewModel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import UIKit

struct NavBarViewModel {
    let displayName: String
    let avatarImage: UIImage?
    let level: PlayerLevel

    init(player: Player, avatarImage: UIImage?) {
        self.displayName = player.firstName
        self.avatarImage = avatarImage
        self.level = player.level
    }
}

// MARK: - Mock Data

extension NavBarViewModel {

	static var mockDefault: NavBarViewModel {
		NavBarViewModel(
			player: Player.mockDefault,
			avatarImage: UIImage(resource: .imgPerson)
		)
    }
}
