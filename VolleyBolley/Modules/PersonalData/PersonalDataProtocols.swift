//
//  PersonalDataProtocols.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 14.09.2025.
//

import UIKit

protocol PersonalDataViewProtocol: AnyObject {
    func updateCountries(_ countries: [String])
    func updateUserData(_ image: UIImage)
}

protocol PersonalDataPresenterProtocol: AnyObject {
    var userData: UIImage? { get }
    var countries: [String] { get }
    var cities: [String] { get }

    func viewDidLoad()
    func backButtonTapped()
    func updateButtonTapped()
    func editProfilePhoto(image: UIImage?)
}

protocol PersonalDataInteractorProtocol: AnyObject {
    func fetchCountries()
    func fetchUserData()
}

protocol PersonalDataInteractorOutputProtocol: AnyObject {
    func didFetchCountries(_ countries: [String])
    func didFetchUserData(image: UIImage)
}

protocol PersonalDataRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
    func navigateBack()
    func showEditProfilePhoto(with image: UIImage?)
}
