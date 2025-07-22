import Foundation

class PhoneRegInteractor: PhoneRegInteractorProtocol {
    weak var presenter: PhoneRegInteractorOutputProtocol?
    
    private let countryCallingCodes: [String: (code: String, pattern: String)] = [
        "RU": ("+7", "### ###-##-##"),   // Россия
        "US": ("+1", "### ###-####"),    // США
        "GB": ("+44", "#### ### ####"),  // Великобритания
        "DE": ("+49", "#### ######"),    // Германия
        "FR": ("+33", "# ## ## ## ##"), // Франция
        "IT": ("+39", "### #######"),   // Италия
        "JP": ("+81", "## #### ####"),  // Япония
        "CN": ("+86", "### #### ####")   // Китай
    ]
    
    func validatePhoneNumber(_ phoneNumber: String) {
        let isValid = validatePhoneNumberFormat(phoneNumber)
        presenter?.phoneValidationResult(isValid: isValid)
        
        if isValid {
            let formattedNumber = formatPhoneNumber(phoneNumber)
            presenter?.didReceiveFormattedNumber(formattedNumber)
        }
    }
    
    private func validatePhoneNumberFormat(_ phoneNumber: String) -> Bool {
        // Удаляем все пробелы и дефисы для проверки
        let cleanedPhone = phoneNumber
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
        
        // Проверяем базовые условия
        guard cleanedPhone.hasPrefix("+"),
              cleanedPhone.count > 1,
              cleanedPhone.rangeOfCharacter(from: CharacterSet(charactersIn: "+0123456789").inverted) == nil else {
            return false
        }
        
        // Получаем код страны
        let countryCode = String(cleanedPhone.dropFirst().prefix(1))
        let numberPart = String(cleanedPhone.dropFirst())
        
        // Проверяем длину в зависимости от страны
        if let regionCode = getCurrentRegionCode(),
           let pattern = countryCallingCodes[regionCode]?.pattern {
            let expectedLength = pattern.replacingOccurrences(of: " ", with: "").count - 1
            return numberPart.count == expectedLength
        }
        
        // Стандартная проверка для неизвестных стран
        return numberPart.count >= 10 && numberPart.count <= 13
    }
    
    // MARK: - Country Code Handling
    
    func getCountryCallingCode() -> String? {
        guard let regionCode = getCurrentRegionCode() else {
            return nil
        }
        return countryCallingCodes[regionCode]?.code ?? "+1"
    }
    
    private func getCurrentRegionCode() -> String? {
        return Locale.current.region?.identifier
    }
    
    // MARK: - Phone Number Formatting
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        // Очищаем номер
        var digits = phoneNumber.filter { $0.isNumber || $0 == "+" }
        
        // Добавляем код страны по умолчанию если нужно
        if !digits.hasPrefix("+") {
            digits = (getCountryCallingCode() ?? "+1") + digits
        }
        
        // Получаем шаблон форматирования для страны
        guard let regionCode = getCurrentRegionCode(),
              let pattern = countryCallingCodes[regionCode]?.pattern else {
            return defaultFormat(digits)
        }
        
        return applyFormat(to: digits, pattern: pattern)
    }
    
    private func defaultFormat(_ digits: String) -> String {
        var result = digits
        
        // Базовое форматирование для неизвестных стран
        if result.count > 3 {
            result.insert(" ", at: result.index(result.startIndex, offsetBy: 3))
        }
        if result.count > 7 {
            result.insert(" ", at: result.index(result.startIndex, offsetBy: 7))
        }
        if result.count > 11 {
            result.insert(" ", at: result.index(result.startIndex, offsetBy: 11))
        }
        
        return result
    }
    
    private func applyFormat(to digits: String, pattern: String) -> String {
        var result = ""
        let cleanDigits = digits.filter { $0.isNumber }
        var digitIndex = 0
        
        for char in pattern {
            if char == "#" {
                if digitIndex < cleanDigits.count {
                    let index = cleanDigits.index(cleanDigits.startIndex, offsetBy: digitIndex)
                    result.append(cleanDigits[index])
                    digitIndex += 1
                }
            } else {
                result.append(char)
            }
        }
        
        // Добавляем оставшиеся цифры без форматирования
        if digitIndex < cleanDigits.count {
            let remainingDigits = String(cleanDigits.dropFirst(digitIndex))
            result.append(" " + remainingDigits)
        }
        
        return result
    }
}
