//
//  UserFormActions.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 07.10.2025.
//

import Foundation

struct UserFormActions {
    let onEditTapped: () -> Void
    let onGenderChanged: (String) -> Void
    let onBirthdayChanged: (String) -> Void
    let onCountrySelected: (String) -> Void
    let onCitySelected: (String) -> Void
    let onUpdateTapped: () -> Void
}
