//
//  AboutPresenter.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import Foundation

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

	private let router: AboutRouterProtocol

	private var items: [AboutItem] = []

	// MARK: - Initializers

	init(router: AboutRouterProtocol) {
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

	enum Constants {
		static let founder = "Dmitrii Zverev"
		static let designers = [
			"Malika Rozieva",
			"Yulia Zemlyanskaya"
		]
		static let developers = [
			"Anastasiia Evdokimovich",
			"Danil Otmakhov",
			"Demian Petropavlov",
			"Egor Partenko",
			"Nikolai Eremenko",
			"Oleg Kozyrev",
			"Roman Romanov"
		]
	}

	func setupAboutInfo() {
		items = [
			AboutItem(
				title: String(localized: "Founder"),
				value: Constants.founder
			),
			AboutItem(
				title: String(localized: "Designed by"),
				value: Constants.designers.joined(separator: "\n")
			),
			AboutItem(
				title: String(localized: "Developed by"),
				value: Constants.developers.joined(separator: "\n")
			)
		]
		view?.reloadData()
	}

	func setupAppVersion() {
		let appVersion = "\(String(localized: "Version")) \(Bundle.main.appVersion)"
		let appAssembly = "\(String(localized: "Build")) \(Bundle.main.appBuild)"
		let appVersionInfo = "\(appVersion)  \(appAssembly)"
		view?.setupAppInfo(with: appVersionInfo)
	}
}
