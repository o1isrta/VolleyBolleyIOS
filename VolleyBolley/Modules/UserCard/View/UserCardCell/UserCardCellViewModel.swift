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
		dateString: String,
		location: LocationTitleViewModel,
		mapButtonCallback: (() -> Void)?
	) {
		// "2025-07-12T14:23:45Z" -> "12 July"
		if let date = AppDateFormatters.iso8601.date(from: dateString) {
			self.date = AppDateFormatters.dayMonth.string(from: date)
		} else {
			self.date = "-"
		}
		self.location = location
		self.mapButtonCallback = mapButtonCallback
	}
}
