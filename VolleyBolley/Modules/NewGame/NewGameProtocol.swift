//
//  NewGameProtocol.swift
//  VolleyBolley
//
//  Created by Олег Кор on 25.07.2025.
//

import UIKit

protocol NewGameViewProtocol: AnyObject {
    func updateDate(_ date: String)
    func updatePlace(_ place: String)
}

protocol NewGamePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapChangePlace()
    func didTapPickDate()
    func didSelectGender(_ gender: Gender)
    func didSelectLevel(_ level: PlayerLevel)
    func didTapNextStep(message: String,
                        from: Date,
                        to: Date)
}

protocol NewGameInteractorProtocol: AnyObject {
    func saveGame(_ game: GameEntity)
}

protocol NewGameInteractorOutputProtocol: AnyObject {
    func gameSaved()
}

protocol NewGameRouterProtocol: AnyObject {
    func navigateToNextStep(with game: GameEntity)
}
