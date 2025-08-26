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
        let cleaned = phoneNumber.filter { $0.isNumber }
        let isValid = cleaned.count >= 10 && cleaned.count <= 15
        presenter?.didValidatePhoneNumber(isValid: isValid)
    }

    func formatPhoneNumber(_ phoneNumber: String) -> String {
        let cleaned = phoneNumber.filter { $0.isNumber || $0 == "+" }
        presenter?.didReceiveFormattedNumber(cleaned)
        return cleaned
    }

    func getCountryCallingCode() -> String? {
        if let region = Locale.current.region?.identifier, let rule = countryRules[region] {
            return rule.code
        }
        return "+1"
    }
}
