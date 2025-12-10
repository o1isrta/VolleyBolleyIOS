//
//  AuthPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    func didTapContinueWithGoogle()
    func didTapContinuePhone()
}

final class AuthPresenter: AuthPresenterProtocol {

    // MARK: - Private properties

    private let interactor: AuthInteractorProtocol
    private let router: AuthRouterProtocol
    private let uiShell: UIShellProtocol

    // MARK: - Initializers

    init(
        interactor: AuthInteractorProtocol,
        router: AuthRouterProtocol,
        uiShell: UIShellProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.uiShell = uiShell
    }

    // MARK: - Public methods

    func didTapContinueWithGoogle() {
        Task {
            uiShell.showLoader()
            do {
                try await interactor.loginWithGoogle()
                uiShell.hideLoader()
                router.finishAuth()
            } catch let error as DomainError {
                uiShell.hideLoader()
                uiShell.showAlert(error, retry: { [weak self] in
                    self?.didTapContinueWithGoogle()
                })
            } catch {
                uiShell.hideLoader()
                uiShell.showAlert(.unknown, retry: nil)
            }
        }
    }

    func didTapContinuePhone() {
        uiShell.showAlert(.common(.notImplemented), retry: nil)
    }
}
