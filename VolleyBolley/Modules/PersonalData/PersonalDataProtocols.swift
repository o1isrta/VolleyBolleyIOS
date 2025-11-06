//
//  PersonalDataProtocols.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 14.09.2025.
//

import UIKit

protocol PersonalDataViewProtocol: AnyObject where Self: UIViewController {
    func updateCountries(_ countries: [String])
}

protocol PersonalDataPresenterProtocol: AnyObject {
    var countries: [String] { get }
    var cities: [String] { get }

    func viewDidLoad()
    func backButtonTapped()
    func updateButtonTapped()
}

protocol PersonalDataInteractorProtocol: AnyObject {
    func fetchCountries()
}

protocol PersonalDataInteractorOutputProtocol: AnyObject {
    func didFetchCountries(_ countries: [String])
}

protocol PersonalDataRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
    func navigateBack()
}
