//
//  UserCardCellViewModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 09.11.2025.
//

import Foundation

struct UserCardCellViewModel {
	let date: String
	let location: LocationTitleViewModel
	let mapButtonCallback: (() -> Void)?

	init(
		date: Date,
		location: LocationTitleViewModel,
		mapButtonCallback: (() -> Void)?
	) {
		self.date = AppDateFormatters.dayMonth.string(from: date)
		self.location = location
		self.mapButtonCallback = mapButtonCallback
	}
}
