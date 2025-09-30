//
//  NewGameAssembly.swift
//  VolleyBolley
//
//  Created by Олег Кор on 25.07.2025.
//

import Swinject

final class NewGameAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NewGameView.self) { resolver in
            let view = NewGameView()
            let interactor = resolver.resolve(NewGameInteractorProtocol.self)!
            let router = NewGameRouter()
            let presenter = NewGamePresenter(view: view, interactor: interactor, router: router)
            view.presenter = presenter
            router.viewController = view
            return view
        }

        container.register(NewGameInteractorProtocol.self) { _ in
            NewGameInteractor()
        }
    }
}
