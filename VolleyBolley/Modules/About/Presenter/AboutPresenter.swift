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
	func getItemsCount() -> Int
	func getItemData(index: Int) -> AboutItem
	func isLastItem(index: Int) -> Bool
}

// MARK: - AboutPresenter

final class AboutPresenter: AboutPresenterProtocol {

	// MARK: - Public Properties

	weak var view: AboutViewProtocol?

	// MARK: - Private Properties

	private let interactor: AboutInteractorProtocol
	private let router: AboutRouterProtocol

	private var items: [AboutItem] = []

	// MARK: - Initializers

	init(interactor: AboutInteractorProtocol, router: AboutRouterProtocol) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		setupAboutInfo()
		setupAppVersion()
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func getItemsCount() -> Int {
		items.count
	}

	func getItemData(index: Int) -> AboutItem {
		items[index]
	}

	func isLastItem(index: Int) -> Bool {
		index == items.count - 1
	}
}

// MARK: - Private Methods

private extension AboutPresenter {

	func setupAboutInfo() {
		let info = interactor.fetchAboutInfo()
		items = [
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
		view?.reloadData()
	}

	func setupAppVersion() {
		let appInfo = interactor.getAppInfo()
		let appVersion = "\(String(localized: "Version")) \(appInfo.appVersion)"
		let appAssembly = "\(String(localized: "Build")) \(appInfo.appBuild)"
		let appVersionInfo = "\(appVersion)  \(appAssembly)"
		view?.setupAppInfo(with: appVersionInfo)
	}
}
