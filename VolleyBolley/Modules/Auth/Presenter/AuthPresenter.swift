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

	weak var view: AuthViewProtocol?
	private let interactor: AuthInteractorProtocol
	private let router: AuthRouterProtocol

	init(
		view: AuthViewProtocol,
		interactor: AuthInteractorProtocol,
		router: AuthRouterProtocol
	) {
		self.view = view
		self.interactor = interactor
		self.router = router
	}

	func phoneButtonTapped() {
//		router.showPhoneAuth()
	}

	func googleButtonTapped() {
		Task {
//			showLoader()
			do {
				try await interactor.loginWithGoogle()
//				hideLoader()
				// TODO: - Finish auth
//				showAlert(.common(.notImplemented), retry: nil)
	//                router.finishAuth()
//			} catch let error as DomainError {
//				hideLoader()
//				showAlert(error, retry: { [weak self] in
//					self?.didTapContinueWithGoogle()
//				})
				print(">>>>> SUCCESS")
			} catch {
				print(">>>>> catch Error")
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
