//
//  PhoneVerificationInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 20.07.2025.
//
import Foundation


final class PhoneVerifyInteractor: PhoneVerifyInteractorProtocol {
    
    weak var presenter: PhoneVerifyInteractorOutputProtocol?
    
    func verifyCode(_ code: String, for phoneNumber: String) {
        // 1. Проверяем базовые требования к коду
        guard code.count == 6 else {
            let error = NSError(
                domain: "",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Код должен содержать 6 цифр"]
            )
            presenter?.verificationFailed(with: error)
            return
        }
        
        // 2. Эмуляция запроса к серверу
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            // 3. Простая проверка кода (в реальном приложении заменить на API вызов)
            if code == "123456" {
                DispatchQueue.main.async {
                    self.presenter?.verificationSucceeded()
                }
            } else {
                let error = NSError(
                    domain: "",
                    code: 401,
                    userInfo: [NSLocalizedDescriptionKey: "Неверный код подтверждения"]
                )
                DispatchQueue.main.async {
                    self.presenter?.verificationFailed(with: error)
                }
            }
        }
    }
}
