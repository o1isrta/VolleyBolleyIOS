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
			// TODO: - loader
			view?.isLoadingIndicatorVisible(true)
			do {
				try await interactor.loginWithGoogle()
				view?.isLoadingIndicatorVisible(false)
				// TODO: - Finish auth
//				showAlert(.common(.notImplemented), retry: nil)
	//                router.finishAuth()
				// TODO: - SUCCESS
				print(">>>>> SUCCESS")
//			} catch let error as DomainError {
//				showAlert(error, retry: { [weak self] in
//					self?.didTapContinueWithGoogle()
//				})
//				print(">>>>> SOME ERROR")
//				view?.isLoadingIndicatorVisible(false)
			} catch {
				print(">>>>> catch Error", DomainError.unknown)
				view?.isLoadingIndicatorVisible(false)
				// TODO: - ERRORS
//				hideLoader()
//				showAlert(.unknown, retry: nil)
			}
		}
	}
}

// MARK: - AuthRouterDelegate

extension AuthPresenter: AuthRouterDelegate {

	func authDidFinish() {
		print(">>>>> authDidFinish")
		router.finishAuth()
	}
}
