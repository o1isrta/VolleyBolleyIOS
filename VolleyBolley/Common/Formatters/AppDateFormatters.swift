//
//  DateFormatters.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

enum AppDateFormatters {

	static let serverDateOnly: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.locale = AppConstants.AppLocale.posix
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		return formatter
	}()

	static let apiDateOnly: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm"
		formatter.locale = AppConstants.AppLocale.posix
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		return formatter
	}()

	static let localizedInterval: DateIntervalFormatter = {
		let formatter = DateIntervalFormatter()
		formatter.locale = Locale.current
		formatter.timeZone = .current
		formatter.dateStyle = .medium
		formatter.timeStyle = .short
		return formatter
	}()

	static let time12Hour: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "h:mm a"
		formatter.amSymbol = "AM"
		formatter.pmSymbol = "PM"
		formatter.locale = AppConstants.AppLocale.posix
		return formatter
	}()

	static let dateWithTime: DateFormatter = {
		let formatter = DateFormatter()
		formatter.locale = AppConstants.AppLocale.posix
		formatter.timeZone = .current
		formatter.dateFormat = "d MMMM, h:mm"
		return formatter
	}()

	static let time: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = AppConstants.AppLocale.posix
		formatter.dateFormat = "h:mm a"
		return formatter
	}()

	static let onlyDate: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .none
		formatter.locale = AppConstants.AppLocale.posix
		formatter.timeZone = .current
		return formatter
	}()
}
