//
//  ProfilePresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol ProfilePresenterProtocol: AnyObject {
	func viewDidLoad()
	func didSelectMenuItem(_ item: ProfileMenuItem)
}

final class ProfilePresenter: ProfilePresenterProtocol {

	// MARK: - Public Properties

	weak var view: ProfileViewProtocol?
	let interactor: ProfileInteractorProtocol
	let router: ProfileRouterProtocol

	// MARK: - Initializers

	init(
		interactor: ProfileInteractorProtocol,
		router: ProfileRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {

	}

	func didSelectMenuItem(_ item: ProfileMenuItem) {
		switch item {
		case .players:
			router.showPlayersList()
		case .personal:
			router.showPersonalData()
		case .support:
			router.showSupport()
		case .faq:
			router.showFAQ()
		case .about:
			router.showAbout()
		default:
			break
		}
	}
}
