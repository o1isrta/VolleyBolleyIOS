//
//  String+Extensions.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 15.09.2025.
//

import Foundation

extension String {

	func capitalizingFirstLetter() -> String {
		guard let first = self.first else { return self }
		let capitalizedFirst = String(first).uppercased()
		let remaining = self.dropFirst().lowercased()
		return capitalizedFirst + remaining
	}

    /// Возвращает отформатированный текст в формате "DD / MM / YYYY" и проходит валидацию
    /// Возвращает `nil`, если строка некорректна (день, месяц, год)
    func formattedBirthdayOrNil() -> String? {
        let digitsOnly = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        if digitsOnly.count > 8 { return nil }

        var formattedText = ""
        let dayEnd = min(2, digitsOnly.count)
        if dayEnd > 0 {
            let day = String(digitsOnly.prefix(dayEnd))
            formattedText += day
            if dayEnd == 2 {
                formattedText += " / "
            }
        }

        let monthStart = 2
        let monthEnd = min(4, digitsOnly.count)
        if monthEnd > monthStart {
            let startIdx = digitsOnly.index(digitsOnly.startIndex, offsetBy: monthStart)
            let endIdx = digitsOnly.index(digitsOnly.startIndex, offsetBy: monthEnd)
            let month = String(digitsOnly[startIdx..<endIdx])
            formattedText += month
            if monthEnd == 4 {
                formattedText += " / "
            }
        }

        let yearStart = 4
        if digitsOnly.count > yearStart {
            let startIdx = digitsOnly.index(digitsOnly.startIndex, offsetBy: yearStart)
            let year = String(digitsOnly[startIdx...])
            formattedText += year
        }

        if digitsOnly.count >= 2 {
            if let dayInt = Int(digitsOnly.prefix(2)), dayInt < 1 || dayInt > 31 {
                return nil
            }
        }

        if digitsOnly.count >= 4 {
            let monthRange = digitsOnly.index(digitsOnly.startIndex, offsetBy: 2)..<digitsOnly.index(digitsOnly.startIndex, offsetBy: 4)
            if let monthInt = Int(digitsOnly[monthRange]), monthInt < 1 || monthInt > 12 {
                return nil
            }
        }

        if digitsOnly.count == 8 {
            let yearRange = digitsOnly.index(digitsOnly.startIndex, offsetBy: 4)..<digitsOnly.index(digitsOnly.startIndex, offsetBy: 8)
            if let yearInt = Int(digitsOnly[yearRange]) {
                let currentYear = Calendar.current.component(.year, from: Date())
                if yearInt > currentYear {
                    return nil
                }
            }
        }

        return formattedText
    }
}
