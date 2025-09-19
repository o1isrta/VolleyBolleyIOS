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

// MARK: - Mock Data

extension NavBarViewModel {

    static var mockDefault: NavBarViewModel {
		NavBarViewModel(
			user: User(
				firstName: "Artem",
				lastName: "Ivanov",
				gender: 0,
				paymentID: 0,
				paymentAccount: "",
				dateOfBirth: Date(),
				level: UserLevel(rawValue: 0),
				countryID: 0,
				cityID: 0,
				avatarURL: nil
			),
			avatarImage: UIImage(resource: .imgPerson)
		)
    }
}
