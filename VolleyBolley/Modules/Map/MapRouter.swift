//
//  MapRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

protocol MapRouterProtocol: AnyObject {
	func showList(from view: MapViewController, courts: [CourtModel], selected: CourtModel?)
    func goBackToHome()
	func goToCreateGameOrTourney(type: GameType, court: CourtModel)
}

final class MapRouter: MapRouterProtocol {

	// MARK: - Public Properties

	weak var viewController: UIViewController?

	// MARK: - Private Properties

	private let newGameOrTourneyVC: () -> NewGameOrTourneyViewController?

	private weak var listVC: CourtListViewController?

	// MARK: - Initializers

	init(
		newGameOrTourneyVC: @escaping () -> NewGameOrTourneyViewController?
	) {
		self.newGameOrTourneyVC = newGameOrTourneyVC
	}

	// MARK: - Public Methods

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func showList(
		from mapViewController: MapViewController,
		courts: [CourtModel],
		selected: CourtModel?
	) {
		let listVC = CourtListViewController(courts: courts, selected: selected)
		mapViewController.addChild(listVC)
		listVC.view.frame = mapViewController.view.bounds
		mapViewController.view.addSubview(listVC.view)
		listVC.didMove(toParent: mapViewController)
		listVC.view.isHidden = false
		self.listVC = listVC
		mapViewController.listView = listVC.view
	}

    func goBackToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }

	func goToCreateGameOrTourney(type: GameType, court: CourtModel) {
		guard let newGameOrTourneyVC = newGameOrTourneyVC() else {
			fatalError("NewGameOrTourneyViewController could not be created")
		}
		newGameOrTourneyVC.presenter?.setupCreateGameWith(type: type, court: court)
		viewController?.navigationController?.pushViewController(newGameOrTourneyVC, animated: true)
	}
}
