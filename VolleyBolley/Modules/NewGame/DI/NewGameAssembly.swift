//
//  NewGameAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Swinject

final class NewGameAssembly: Assembly {

    func assemble(container: Container) {
		container.register(NewGameInteractorProtocol.self) { _ in
			NewGameInteractor()
		}

        container.register(NewGameView.self) { resolver in
            let view = NewGameView()
			guard
				let interactor = resolver.resolve(NewGameInteractorProtocol.self)
			else {
				fatalError("Error: Failed to register NewGameInteractorProtocol")
			}
            let router = NewGameRouter()
            let presenter = NewGamePresenter(view: view, interactor: interactor, router: router)
            view.presenter = presenter
            router.viewController = view
            return view
        }
    }
}
