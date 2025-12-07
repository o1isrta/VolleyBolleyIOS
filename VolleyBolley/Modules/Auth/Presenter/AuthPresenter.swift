//
//  AuthPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import Combine
import Foundation

@MainActor
protocol AuthPresenterProtocol: AnyObject {
    var statePublisher: Published<AuthViewState>.Publisher { get }
    func didTapContinueWithGoogle()
    func didTapContinuePhone()
}

@MainActor
final class AuthPresenter: AuthPresenterProtocol {

    // MARK: - Public properties

    var statePublisher: Published<AuthViewState>.Publisher { $state }

    // MARK: - Private properties

    @Published private var state: AuthViewState = .idle

    private let interactor: AuthInteractorProtocol
    private let router: AuthRouterProtocol
    private let uiShell: UIShellProtocol

    private var cancellables: Set<AnyCancellable> = []

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

            state = .loading
            do {
                try await interactor.loginWithGoogle()
                router.finishAuth()
            } catch let error as DomainError {
                uiShell.showAlert(error, retry: { [weak self] in
                    self?.didTapContinueWithGoogle()
                })
            } catch {
                uiShell.showAlert(.unknown)
            }
        }
    }

    func didTapContinuePhone() {
        uiShell.showAlert(.common(.notImplemented))
    }
}
