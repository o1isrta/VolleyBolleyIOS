//
//  NewGameOrTourneyController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

protocol NewGameOrTourneyControllerProtocol: AnyObject {
	var presenter: NewGameOrTourneyPresenterProtocol? { get set }
}

final class NewGameOrTourneyController: BaseViewController, NewGameOrTourneyControllerProtocol {

	// MARK: - Public Properties

	var presenter: NewGameOrTourneyPresenterProtocol?

	// MARK: - Private Properties
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyController()
}
#endif
