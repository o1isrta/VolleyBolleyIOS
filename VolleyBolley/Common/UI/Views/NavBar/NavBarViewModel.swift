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
    let level: UserLevel

    init(user: User, avatarImage: UIImage?) {
        self.displayName = user.firstName
        self.avatarImage = avatarImage
        self.level = user.level
    }
}
