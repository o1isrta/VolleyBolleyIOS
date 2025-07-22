//
//  DateFormatters.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

enum DateFormatters {
    /// Для работы с сервером (парсинг и сериализация)
    static let serverDateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    /// Для отображения пользователю — формат из макета (Figma)
    static let uiDateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / yyyy" // IMPORTANT: формат из макета
        formatter.locale = Locale.current
        formatter.timeZone = .current
        return formatter
    }()
}
