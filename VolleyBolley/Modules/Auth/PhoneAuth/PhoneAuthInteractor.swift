//
//  PhoneRegInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//
import Foundation

class PhoneAuthInteractor: PhoneAuthInteractorProtocol {
    weak var presenter: PhoneAuthInteractorOutputProtocol?

    private struct CountryRule {
        let code: String
        let pattern: String
    }

    private let countryRules: [String: CountryRule] = [
        "RU": CountryRule(code: "+7",  pattern: "### ###-##-##"),
        "US": CountryRule(code: "+1",  pattern: "### ###-####"),
        "GB": CountryRule(code: "+44", pattern: "#### ### ####"),
        "DE": CountryRule(code: "+49", pattern: "#### ######"),
        "FR": CountryRule(code: "+33", pattern: "# ## ## ## ##"),
        "IT": CountryRule(code: "+39", pattern: "### #######"),
        "JP": CountryRule(code: "+81", pattern: "## #### ####"),
        "CN": CountryRule(code: "+86", pattern: "### #### ####")
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
        let cleanedPhone = phoneNumber.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")

        guard cleanedPhone.hasPrefix("+"),
              cleanedPhone.dropFirst().allSatisfy(\.isNumber) else {
            return false
        }

        if let region = extractRegionCode(from: cleanedPhone),
           let rule = countryRules[region] {
            let expectedLength = rule.pattern.filter { $0 == "#" }.count
            let numberPart = cleanedPhone.dropFirst(rule.code.count)
            return numberPart.count == expectedLength
        }

        let numberPart = cleanedPhone.dropFirst()
        return numberPart.count >= 10 && numberPart.count <= 15
    }

    func getCountryCallingCode() -> String? {
        if let regionCode = Locale.current.region?.identifier,
           let rule = countryRules[regionCode] {
            return rule.code
        }
        return "+1"
    }

    private func extractRegionCode(from phone: String) -> String? {
        for (region, rule) in countryRules {
            if phone.hasPrefix(rule.code) {
                return region
            }
        }
        return nil
    }

    func formatPhoneNumber(_ phoneNumber: String) -> String {
        var digits = phoneNumber.filter { $0.isNumber || $0 == "+" }
        if !digits.hasPrefix("+") {
            digits = (getCountryCallingCode() ?? "+1") + digits
        }

        if let region = extractRegionCode(from: digits),
           let rule = countryRules[region] {
            return applyFormat(to: digits, pattern: rule.pattern)
        }

        return defaultFormat(digits)
    }

    private func defaultFormat(_ digits: String) -> String {
        var result = digits
        if result.count > 3 { result.insert(" ", at: result.index(result.startIndex, offsetBy: 3)) }
        if result.count > 7 { result.insert(" ", at: result.index(result.startIndex, offsetBy: 7)) }
        if result.count > 11 { result.insert(" ", at: result.index(result.startIndex, offsetBy: 11)) }
        return result
    }

    private func applyFormat(to digits: String, pattern: String) -> String {
        var result = "+"
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

        if digitIndex < cleanDigits.count {
            result.append(" " + cleanDigits.dropFirst(digitIndex))
        }

        return result
    }
}
