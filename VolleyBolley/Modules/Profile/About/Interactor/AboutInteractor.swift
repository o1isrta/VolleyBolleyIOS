//
//  AboutInteractor.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

// MARK: - AboutInteractorProtocol

protocol AboutInteractorProtocol: AnyObject {
    func fetchAboutInfo() -> AboutInfo
}

// MARK: - AboutInfo

struct AboutInfo {
    let founder: String
    let designers: [String]
    let developers: [String]
}

// MARK: - AboutInteractor

final class AboutInteractor: AboutInteractorProtocol {

    // MARK: - Constants

    private enum Constants {
        static let founder = "Dmitrii Zverev"
        static let designers = ["Malika Rozieva", "Zemlyanskaya Yulia"]
        static let developers = ["Team VolleyBolley"]
    }

    // MARK: - AboutInteractorProtocol

    func fetchAboutInfo() -> AboutInfo {
        AboutInfo(
            founder: Constants.founder,
            designers: Constants.designers,
            developers: Constants.developers
        )
    }
}
