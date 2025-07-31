//
//  UserRegProtocols.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//
import UIKit

protocol UserRegViewProtocol: AnyObject {
    func updateCountries(_ countries: [String])
}

protocol UserRegPresenterProtocol: AnyObject {
    var countries: [String] { get }
    var cities: [String] { get }

    func viewDidLoad()
    func didTapLevelInfo()
    func didTapGetStarted(name: String, surname: String, gender: String)
}

protocol UserRegInteractorProtocol: AnyObject {
    var presenter: UserRegInteractorOutputProtocol? { get set }

    func fetchCountries()
    func registerUser(name: String, surname: String, gender: String)
}

protocol UserRegInteractorOutputProtocol: AnyObject {
    func didFetchCountries(_ countries: [String])
    func registrationDidSucceed()
    func registrationDidFail(error: Error)
}

protocol UserRegRouterProtocol: AnyObject {
    static func assembleModule() -> UIViewController
    func showLevelInfoScreen()
    func navigateToNextScreen()
}
