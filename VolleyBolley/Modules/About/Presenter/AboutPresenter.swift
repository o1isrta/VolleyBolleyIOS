//
//  AboutPresenter.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

// MARK: - AboutPresenterProtocol

protocol AboutPresenterProtocol: AnyObject {
	func viewDidLoad()
	func backButtonTapped()
}

// MARK: - AboutPresenter

final class AboutPresenter: AboutPresenterProtocol {

	// MARK: - Public Properties

	weak var view: AboutViewProtocol?

	// MARK: - Private Properties

	private let interactor: AboutInteractorProtocol
	private let router: AboutRouterProtocol

	// MARK: - Initializers

	init(interactor: AboutInteractorProtocol, router: AboutRouterProtocol) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		let info = interactor.fetchAboutInfo()
		let appInfo = interactor.getAppInfo()
		let viewModel = AboutViewModel(
			founder: info.founder,
			designers: info.designers,
			developers: info.developers,
			appVersion: appInfo.appVersion,
			appBuild: appInfo.appBuild
		)
		view?.displayAboutInfo(viewModel)
	}

	func backButtonTapped() {
		router.navigateBack()
	}
}
