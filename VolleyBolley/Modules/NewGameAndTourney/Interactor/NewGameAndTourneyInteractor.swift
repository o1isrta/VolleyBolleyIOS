//
//  NewGameAndTourneyInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Foundation

protocol NewGameAndTourneyInteractorProtocol: AnyObject {
	var presenter: NewGameAndTourneyPresenterProtocol? { get set }
}

final class NewGameAndTourneyInteractor: NewGameAndTourneyInteractorProtocol {

	var presenter: NewGameAndTourneyPresenterProtocol?
}
