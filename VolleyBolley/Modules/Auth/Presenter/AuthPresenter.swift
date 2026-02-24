//
//  AuthPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
	func phoneButtonTapped()
	func googleButtonTapped()
}

final class AuthPresenter: AuthPresenterProtocol {

	weak var view: AuthViewControllerProtocol?
	private let interactor: AuthInteractorProtocol
	private let router: AuthRouterProtocol

	init(
		interactor: AuthInteractorProtocol,
		router: AuthRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	func phoneButtonTapped() {
//		router.showPhoneAuth()
	}

	func googleButtonTapped() {
		Task {
			view?.isLoadingIndicatorVisible(true)
			do {
				try await interactor.loginWithGoogle()
				view?.isLoadingIndicatorVisible(false)
				// TODO: - SUCCESS
//                router.finishAuth()
				print(">>>>> SUCCESS")
			} catch let error as DomainError {
				view?.isLoadingIndicatorVisible(false)
				await MainActor.run {
					view?.showAlert(with: error.localizedDescription)
				}
			} catch {
				view?.isLoadingIndicatorVisible(false)
				await MainActor.run {
					view?.showAlert(with: AuthError.signInFailed.localizedDescription)
				}
			}
		}
	}
}

// MARK: - AuthRouterDelegate

extension AuthPresenter: AuthRouterDelegate {

	func authDidFinish() {
		// TODO: - authDidFinish
		print(">>>>> authDidFinish")
		router.finishAuth()
	}
}
