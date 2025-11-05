//
//  UserFormActions.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 07.10.2025.
//

import UIKit

struct UserFormActions {
	let onEditTapped: (UIImage?) -> Void
	// TODO: пока решили убрать возможность изменения пола через ЛК, возможно после запуска MVP вернуть придется
	/*
    let onGenderChanged: (String) -> Void
	*/
    let onBirthdayChanged: (String) -> Void
    let onCountrySelected: (String) -> Void
    let onCitySelected: (String) -> Void
    let onUpdateTapped: () -> Void
}
