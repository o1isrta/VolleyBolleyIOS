//
//  AboutInteractor.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

protocol AboutInteractorProtocol: AnyObject {
    func fetchAboutInfo() -> AboutInfo
}

struct AboutInfo {
    let founder: String
    let designers: [String]
    let developers: [String]
}

final class AboutInteractor: AboutInteractorProtocol {
    func fetchAboutInfo() -> AboutInfo {
        return AboutInfo(
            founder: "Dmitrii Zverev",
            designers: ["Malika Rozieva", "Zemlyanskaya Yulia"],
            developers: ["Team VolleyBolley"]
        )
    }
}

