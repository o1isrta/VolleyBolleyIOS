//
//  PlayersListPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 28.11.2025.
//

import Foundation

// MARK: - PlayersListPresenterProtocol

protocol PlayersListPresenterProtocol: AnyObject {
	func viewDidLoad()
	func backButtonTapped()
}

// MARK: - PlayersListPresenter

final class PlayersListPresenter: PlayersListPresenterProtocol {

	// MARK: - Public Properties

	weak var view: PlayersListViewControllerProtocol?
	var interactor: PlayersListInteractorProtocol?
	var router: PlayersListRouterProtocol

	// MARK: - Private Properties

	// MARK: - Initializers

	init(
		interactor: PlayersListInteractorProtocol,
		router: PlayersListRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		print("load players list")
	}

	func backButtonTapped() {
		router.navigateBack()
	}
}
