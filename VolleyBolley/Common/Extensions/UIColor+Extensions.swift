//
//  UIColor+Extensions.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

extension UIColor {
    /// Инициализирует цвет `UIColor` из шестнадцатеричной строки.
    ///
    /// - Параметры:
    ///   - hex: Строка с шестнадцатеричным кодом цвета. Может начинаться с символа `#` или без него. Должна содержать 6 символов (например, `"#FF5733"` или `"FF5733"`).
    ///   - alpha: Необязательное значение прозрачности от 0.0 до 1.0. По умолчанию — 1.0 (полностью непрозрачный).
    ///
    /// - Примечание: Поддерживаются только шестизначные значения (формат RGB). Короткий формат (`#FFF`) и значения с альфой (`#RRGGBBAA`) не поддерживаются.
    ///
    /// - Пример использования:
    /// ```swift
    /// let цвет = UIColor(hex: "#1E90FF")
    /// let полупрозрачный = UIColor(hex: "1E90FF", alpha: 0.5)
    /// ```
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let blue = CGFloat(rgb & 0x0000FF) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
