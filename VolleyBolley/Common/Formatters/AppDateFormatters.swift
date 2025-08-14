//
//  DateFormatters.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

enum AppDateFormatters {
    /// Для работы с сервером (парсинг и сериализация)
    static let serverDateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

	static let apiDateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
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

	static let dateWithTime: DateFormatter = {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
		formatter.timeZone = .current
		formatter.dateFormat = "d MMMM, h:mm"
		return formatter
	}()

	static let time: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = .current
		formatter.locale = Locale(identifier: "en_US")
		formatter.dateFormat = "h:mm a"
		return formatter
	}()
}
