//
//  MapAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.08.2025.
//

import Swinject

final class MapAssembly: Assembly {

	func assemble(container: Container) {
		container.register(MapViewController.self) { resolver in
			guard
				let networkService = resolver.resolve(NetworkServiceProtocol.self)
			else {
				fatalError("Error: Failed to register NetworkService")
			}

			let router = MapRouter()
			let interactor = MapInteractor(networkService: networkService)

			let presenter = MapPresenter(
				interactor: interactor,
				router: router
			)

			let view = MapViewController(presenter: presenter)
			router.attachViewController(view)
			presenter.view = view

			return view
		}
	}
}
