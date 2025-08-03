//
//  Date+UI.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 23.07.2025.
//

import Foundation

extension Date {

	func localizedIntervalString(to endDate: Date) -> String {
		AppDateFormatters.localizedInterval.string(from: self, to: endDate)
	}

	static func formatDateRange(startString: String, endString: String) -> String? {
		let inputFormatter = AppDateFormatters.apiDateOnly
		
		guard
			let startDate = inputFormatter.date(from: startString),
			let endDate = inputFormatter.date(from: endString)
		else {
			return nil
		}

		let startDateFormatter = AppDateFormatters.dateWithTime
		let endTimeFormatter = AppDateFormatters.time

		let startTime = startDateFormatter.string(from: startDate)
		let endTime = endTimeFormatter.string(from: endDate).lowercased()

		return "\(startTime)-\(endTime)"
	}
}
