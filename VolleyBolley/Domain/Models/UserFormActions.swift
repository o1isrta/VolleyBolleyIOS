//
//  UserFormActions.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 07.10.2025.
//

import UIKit

struct UserFormActions {
	let onEditTapped: (UIImage?) -> Void
    let onGenderChanged: (String) -> Void
    let onBirthdayChanged: (String) -> Void
    let onCountrySelected: (String) -> Void
    let onCitySelected: (String) -> Void
    let onUpdateTapped: () -> Void
}
