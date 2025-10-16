//
//  NewGameAndTourneyController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

protocol NewGameAndTourneyControllerProtocol: AnyObject {
	var presenter: NewGameAndTourneyPresenterProtocol? { get set }
}

final class NewGameAndTourneyController: BaseViewController, NewGameAndTourneyControllerProtocol {

	// MARK: - Public Properties

	var presenter: NewGameAndTourneyPresenterProtocol?

	// MARK: - Private Properties
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameAndTourneyController()
}
#endif
