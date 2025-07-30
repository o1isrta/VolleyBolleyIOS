//
//  NewGameProtocol.swift
//  VolleyBolley
//
//  Created by Олег Кор on 25.07.2025.
//

import UIKit

protocol NewGameViewProtocol: AnyObject {
//    func updateCountries(_ countries: [String])
}

protocol NewGamePresenterProtocol: AnyObject {
//    var countries: [String] { get }
//    var cities: [String] { get }
//
//    func viewDidLoad()
//    func didTapLevelInfo()
//    func didTapGetStarted(name: String, surname: String, gender: String)
}

protocol NewGameInteractorProtocol: AnyObject {
//    var presenter: UserRegInteractorOutputProtocol? { get set }
//
//    func fetchCountries()
//    func registerUser(name: String, surname: String, gender: String)
}

protocol NewGameInteractorOutputProtocol: AnyObject {
//    func didFetchCountries(_ countries: [String])
//    func registrationDidSucceed()
//    func registrationDidFail(error: Error)
}

protocol NewGameRouterProtocol: AnyObject {
//    static func assembleModule() -> UIViewController
//    func showLevelInfoScreen()
//    func navigateToNextScreen()
}
