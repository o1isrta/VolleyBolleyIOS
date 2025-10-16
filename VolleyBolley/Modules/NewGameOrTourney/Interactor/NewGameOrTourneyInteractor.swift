//
//  NewGameOrTourneyInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Foundation

protocol NewGameOrTourneyInteractorProtocol: AnyObject {
	var presenter: NewGameOrTourneyPresenterProtocol? { get set }
}

final class NewGameOrTourneyInteractor: NewGameOrTourneyInteractorProtocol {

	var presenter: NewGameOrTourneyPresenterProtocol?
}
