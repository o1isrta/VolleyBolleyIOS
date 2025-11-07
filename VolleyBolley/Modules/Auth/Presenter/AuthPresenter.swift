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

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(
        interactor: AuthInteractorProtocol,
        router: AuthRouterProtocol,
    ) {
        self.interactor = interactor
        self.router = router
        bindInteractor()
    }

    // MARK: - Public methods

    func didTapContinueWithGoogle() {
        state = .loading
        interactor.loginWithGoogle()
    }

    func didTapContinuePhone() {
        state = .alertError(String(localized: "Not implemented yet"))
    }

    private func bindInteractor() {
        interactor.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.state = .loading
                case .success:
                    self?.router.finishAuth()
                case .alertError(let message):
                    self?.state = .alertError(message)
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
