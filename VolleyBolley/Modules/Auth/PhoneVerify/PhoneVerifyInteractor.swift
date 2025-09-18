//
//  PhoneVerifyInteractor.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//
import Foundation

final class PhoneVerifyInteractor: PhoneVerifyInteractorProtocol {

    weak var presenter: PhoneVerifyInteractorOutputProtocol?

    func verifyCode(_ code: String, for phoneNumber: String) {
        let digitsOnly = code.filter { $0.isNumber }
        guard digitsOnly.count == PhoneVerifyPresenter.verificationCodeLength else {
            let error = NSError(
                domain: "",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Код должен содержать 6 цифр"]
            )
            presenter?.verificationFailed(with: error)
            return
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            if digitsOnly == "123456" {
                DispatchQueue.main.async {
                    self.presenter?.verificationSucceeded()
                    // TODO: Заменить на реальный код из смс
                }
            } else {
                let error = NSError(
                    domain: "",
                    code: 401,
                    userInfo: [NSLocalizedDescriptionKey: String(localized: "Invalid code")]
                )
                DispatchQueue.main.async {
                    self.presenter?.verificationFailed(with: error)
                }
            }
        }
    }

    func verifyCodeForValidation(_ code: String, for phoneNumber: String) {
        let digitsOnly = code.filter { $0.isNumber }
        guard digitsOnly.count == PhoneVerifyPresenter.verificationCodeLength else { return }

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) { [weak self] in
            DispatchQueue.main.async {
                if digitsOnly != "123456" {
                    let error = NSError(domain: "", code: 401,
                        userInfo: [NSLocalizedDescriptionKey: String(localized: "Invalid code")])
                    self?.presenter?.validationFailed(with: error)
                } else {
                    self?.presenter?.validationSucceeded()
                }
            }
        }
    }

    func resendCode(for phoneNumber: String) {
        print("Запрос повторного отправления кода")
        // TODO: Добавить сетевой запрос повторной отправки смс-кода
    }
}
