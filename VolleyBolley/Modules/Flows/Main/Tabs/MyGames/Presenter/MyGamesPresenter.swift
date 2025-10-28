//
//  MyGamesPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import Foundation

protocol MyGamesPresenterProtocol: AnyObject {
    func viewDidLoad()
	func getItemsCount() -> Int
	func getItemData(index: Int) -> MyGamesViewItem
	func isLastItem(index: Int) -> Bool
	func didSelectMenuItem(at index: Int)
}

final class MyGamesPresenter: MyGamesPresenterProtocol {

    // MARK: - Public Properties

    weak var view: MyGamesViewProtocol?
    let interactor: MyGamesInteractorProtocol
    let router: MyGamesRouterProtocol

	// MARK: - Private Properties

	private var gameMenuItems: [MyGamesViewItem] =  [
		MyGamesViewItem(type: .myGames, title: String(localized: "myGames.games")),
		MyGamesViewItem(type: .upcomingGames, title: String(localized: "myGames.Upcoming")),
		MyGamesViewItem(type: .gameInvites, title: String(localized: "myGames.invites")),
		MyGamesViewItem(type: .completedGames, title: String(localized: "myGames.Archive"))
	]

    // MARK: - Initializers

    init(
        interactor: MyGamesInteractorProtocol,
        router: MyGamesRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
		getMenuItems()
    }

	func getItemsCount() -> Int {
		gameMenuItems.count
	}

	func getItemData(index: Int) -> MyGamesViewItem {
		gameMenuItems[index]
	}

	func isLastItem(index: Int) -> Bool {
		index == gameMenuItems.count - 1
	}

	func didSelectMenuItem(at index: Int) {
		switch gameMenuItems[index].type {
		case .myGames:
			router.showMyGames()
		case .upcomingGames:
			router.showUpcomingGames()
		case .gameInvites:
			router.showGameInvites()
		case .completedGames:
			router.showArchive()
		}
	}
}

// MARK: - Private Methods

private extension MyGamesPresenter {

	func getMenuItems() {
		Task {
			async let nextGameDate = interactor.getNextGameDate()
			async let invitesCount = interactor.getInvitesCount()
			let nextGameDateString = AppDateFormatters.monthDay.string(from: await nextGameDate)
			gameMenuItems = [
				MyGamesViewItem(type: .myGames, title: String(localized: "myGames.games")),
				MyGamesViewItem(
					type: .upcomingGames,
					title: String(localized: "myGames.Upcoming"),
					description: "\(String(localized: "myGames.NextGame")): \(nextGameDateString)"
				),
				MyGamesViewItem(
					type: .gameInvites,
					title: String(localized: "myGames.invites"),
					badge: await invitesCount.description
				),
				MyGamesViewItem(type: .completedGames, title: String(localized: "myGames.Archive"))
			]
			await view?.reloadData()
		}
	}
}
