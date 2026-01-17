//
//  RegistrationInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import Foundation

protocol RegistrationInteractorProtocol: AnyObject {
	var presenter: RegistrationInteractorOutputProtocol? { get set }

	func fetchCountries()
	func registerUser(name: String, surname: String, gender: String)
}

protocol RegistrationInteractorOutputProtocol: AnyObject {
	func didFetchCountries(_ countries: [String])
	func registrationDidSucceed()
	func registrationDidFail(error: Error)
}

final class RegistrationInteractor: RegistrationInteractorProtocol {

	weak var presenter: RegistrationInteractorOutputProtocol?

	func fetchCountries() {
		// TODO: -
		let mockCountries = ["Cyprus", "Thailand", "Poland", "Germany"]
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.presenter?.didFetchCountries(mockCountries)
		}
	}

	// TODO: -
	func registerUser(name: String, surname: String, gender: String) {
		if name.isEmpty || surname.isEmpty || gender.isEmpty {
			presenter?.registrationDidFail(
				error: NSError(
					domain: "",
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "All fields required"]
				)
			)
		} else {
			presenter?.registrationDidSucceed()
		}
	}
}
