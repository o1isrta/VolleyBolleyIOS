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
		let items = [
			AboutItem(
				title: String(localized: "Founder"),
				value: info.founder
			),
			AboutItem(
				title: String(localized: "Designed by"),
				value: info.designers.joined(separator: "\n")
			),
			AboutItem(
				title: String(localized: "Developed by"),
				value: info.developers.joined(separator: "\n")
			)
		]

		let appInfo = interactor.getAppInfo()
		let appVersion = "\(String(localized: "Version")) \(appInfo.appVersion)"
		let appAssembly = "\(String(localized: "Build")) \(appInfo.appBuild)"
		let appVersionInfo = "\(appVersion)  \(appAssembly)"
		let viewModel = AboutViewModel(items: items, appVersionInfo: appVersionInfo)

		view?.displayAboutInfo(viewModel)
	}

	func backButtonTapped() {
		router.navigateBack()
	}
}
