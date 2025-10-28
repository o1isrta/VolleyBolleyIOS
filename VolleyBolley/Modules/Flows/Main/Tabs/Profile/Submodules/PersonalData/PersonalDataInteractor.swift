//
//  PersonalDataInteractor.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

final class PersonalDataInteractor: PersonalDataInteractorProtocol {

    weak var presenter: PersonalDataInteractorOutputProtocol?

    func fetchCountries() {
        let mockCountries = ["Cyprus", "Thailand", "Poland", "Germany"]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.presenter?.didFetchCountries(mockCountries)
        }
    }

	func fetchUserData() {
		let image = UIImage.imgPerson
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.presenter?.didFetchUserData(image: image)
		}
	}
}
