//
//  CreateGameAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import Swinject
import UIKit

final class CreateGameAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(
		invitePlayersFactory: @escaping (
			InvitePlayersListType,
			Int,
			[InvitePlayerModel],
			@escaping ([InvitePlayerModel]) -> Void
		) -> InvitePlayersViewController?
	) -> CreateGameViewController {
		let createGameVC = CreateGameViewController()
		let interactor = CreateGameInteractor()
		let router = CreateGameRouter(
			viewController: createGameVC,
			invitePlayersFactory: invitePlayersFactory
		)
		let presenter = CreateGamePresenter(
			interactor: interactor,
			router: router
		)

		createGameVC.presenter = presenter
		interactor.presenter = presenter
		presenter.view = createGameVC

		return createGameVC
	}

	// MARK: - Swinject Assembly

	func assemble(container: Container) {
		container.register(CreateGameViewController.self) { resolver in
			let invitePlayersFactory: (
				InvitePlayersListType,
				Int,
				[InvitePlayerModel],
				@escaping ([InvitePlayerModel]) -> Void
			) -> InvitePlayersViewController? = { type, maxPlayers, invitePlayers, onSelected in
				resolver.resolve(InvitePlayersViewController.self, arguments: type, maxPlayers, invitePlayers, onSelected)
			}
			return CreateGameAssembly.createModule(invitePlayersFactory: invitePlayersFactory)
		}
	}
}
