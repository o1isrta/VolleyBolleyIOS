//
//  UserRegInteractor.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//
import Foundation

class UserRegInteractor: UserRegInteractorProtocol {

    weak var presenter: UserRegInteractorOutputProtocol?

    func fetchCountries() {
            let mockCountries = ["Cyprus", "Thailand", "Poland", "Germany"]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presenter?.didFetchCountries(mockCountries)
            }
        }

    func registerUser(name: String, surname: String, gender: String) {
        if name.isEmpty || surname.isEmpty || gender.isEmpty {
            presenter?.registrationDidFail(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "All fields required"]))
        } else {
            presenter?.registrationDidSucceed()
        }
    }
}
