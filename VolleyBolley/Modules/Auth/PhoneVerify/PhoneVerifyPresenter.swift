//
//  PhoneVerifyPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 18.08.2025.
//
import UIKit

final class PhoneVerifyPresenter: PhoneVerifyPresenterProtocol, PhoneVerifyInteractorOutputProtocol {

    weak var view: PhoneVerifyViewProtocol?
    var interactor: PhoneVerifyInteractorProtocol
    var router: PhoneVerifyRouterProtocol
    private let phoneNumber: String

    init(view: PhoneVerifyViewProtocol,
         interactor: PhoneVerifyInteractorProtocol,
         router: PhoneVerifyRouterProtocol,
         phoneNumber: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.phoneNumber = phoneNumber
    }

    func viewDidLoad() {
        view?.enableVerifyButton(false)
    }

    func didTapBack() {
        router.navigateBack()
    }

    func codeDidChange(_ code: String) {
        let digitsOnly = code.filter { $0.isNumber }
        view?.enableVerifyButton(digitsOnly.count == 6)
    }

    func didTapVerify(with code: String) {
        interactor.verifyCode(code, for: phoneNumber)
    }

    func verificationSucceeded() {
        router.navigateToMainScreen()
    }

    func verificationFailed(with error: Error) {
        view?.enableVerifyButton(false)
        if let view = view as? UIViewController {
            let alert = UIAlertController(title: "Error",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            view.present(alert, animated: true)
        }
    }

    func didTapResendCode() {
        interactor.resendCode(for: phoneNumber)
    }
}
