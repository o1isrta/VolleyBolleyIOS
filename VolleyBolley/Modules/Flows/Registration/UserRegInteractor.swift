//
//  UserRegInteractor.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//

import Foundation

protocol UserRegInteractorProtocol: AnyObject {}

protocol UserRegInteractorOutputProtocol: AnyObject {
    func didRegisterSuccessfully(isRegistered: Bool)
    func didFailToRegister(error: Error)
}

final class UserRegInteractor: UserRegInteractorProtocol {

    // MARK: - Public Properties

    weak var presenter: UserRegInteractorOutputProtocol?
}
