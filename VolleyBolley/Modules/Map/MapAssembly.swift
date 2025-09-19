//
//  MapAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.08.2025.
//

import Swinject

final class MapAssembly: Assembly {

	func assemble(container: Container) {
		container.register(MapViewController.self) { _ in
			let router = MapRouter()
			let interactor = MapInteractor()

			let presenter = MapPresenter(
				interactor: interactor,
				router: router
			)

			let view = MapViewController(presenter: presenter)
			router.attachViewController(view)
			presenter.view = view

			return view
		}

        container.register(MapModuleFactoryProtocol.self) { resolver in
            MapModuleFactory(resolver: resolver)
        }
        .inObjectScope(.container)
	}
}
