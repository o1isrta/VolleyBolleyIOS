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

	/// Возвращает отформатированный текст в виде
	/// "DD / MM / YYYY", если дата валидна.
	/// Возвращает `nil`, если день, месяц или год некорректны.
	func formattedBirthdayOrNil() -> String? {
		let digitsOnly = replacingOccurrences(
			of: "[^0-9]",
			with: "",
			options: .regularExpression
		)

		guard digitsOnly.count <= 8 else { return nil }

		var formattedText = ""

		if !digitsOnly.isEmpty {
			formattedText += String(digitsOnly.prefix(2))
			if digitsOnly.count > 2 { formattedText += " / " }
		}

		if digitsOnly.count > 2 {
			formattedText += String(digitsOnly.dropFirst(2).prefix(2))
			if digitsOnly.count > 4 { formattedText += " / " }
		}

		if digitsOnly.count > 4 {
			formattedText += String(digitsOnly.dropFirst(4))
		}

		guard
			isValidDay(digitsOnly),
			isValidMonth(digitsOnly),
			isValidYear(digitsOnly)
		else { return nil }

		return formattedText
	}

	// MARK: - Private Methods

	/// Проверяет, что день в диапазоне 1...31
	private func isValidDay(_ digits: String) -> Bool {
		guard digits.count >= 2,
			  let dayInt = Int(digits.prefix(2)) else { return true }
		return (1...31).contains(dayInt)
	}

	/// Проверяет, что месяц в диапазоне 1...12
	private func isValidMonth(_ digits: String) -> Bool {
		guard digits.count >= 4 else { return true }
		let start = digits.index(digits.startIndex, offsetBy: 2)
		let end = digits.index(digits.startIndex, offsetBy: 4)
		guard let monthInt = Int(digits[start..<end]) else { return true }
		return (1...12).contains(monthInt)
	}

	/// Проверяет, что год не в будущем
	private func isValidYear(_ digits: String) -> Bool {
		guard digits.count == 8 else { return true }
		let start = digits.index(digits.startIndex, offsetBy: 4)
		let end = digits.index(digits.startIndex, offsetBy: 8)
		guard let yearInt = Int(digits[start..<end]) else { return true }
		let currentYear = Calendar.current.component(.year, from: Date())
		return yearInt <= currentYear
	}
}
