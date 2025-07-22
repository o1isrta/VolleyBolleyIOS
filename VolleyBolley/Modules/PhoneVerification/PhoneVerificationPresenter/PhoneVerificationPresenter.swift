//
//  PhoneVerificationPresenter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 20.07.2025.
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
        view?.enableVerifyButton(code.count == 6)
    }
    
    func didTapVerify(with code: String) {
        interactor.verifyCode(code, for: phoneNumber)
    }
    
    func verificationSucceeded() {
        router.navigateToMainScreen()
    }
    
    func verificationFailed(with error: Error) {
        //
    }
}
