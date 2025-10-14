//
//  AboutInteractor.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import Foundation

// MARK: - AboutInteractorProtocol

protocol AboutInteractorProtocol: AnyObject {
	func fetchAboutInfo() -> AboutInfo
	func getAppInfo() -> AppInfo
}

// MARK: - AboutInfo

struct AboutInfo {
	let founder: String
	let designers: [String]
	let developers: [String]
}

// MARK: - AppInfo

struct AppInfo {
	let appVersion: String
	let appBuild: String
}

// MARK: - AboutInteractor

final class AboutInteractor: AboutInteractorProtocol {

	// MARK: - Private Properties

	private enum Constants {
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
			"Roman Romanov",
			"Vadim Mikheev"
		]
	}

	// MARK: - Public Methods

	func fetchAboutInfo() -> AboutInfo {
		AboutInfo(
			founder: Constants.founder,
			designers: Constants.designers,
			developers: Constants.developers
		)
	}

	func getAppInfo() -> AppInfo {
		AppInfo(
			appVersion: Bundle.main.appVersion,
			appBuild: Bundle.main.appBuild
		)
	}
}
