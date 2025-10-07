//
//  SupportAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import Swinject

final class SupportAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SupportViewController.self) { _ in
            let router = SupportRouter()
            let interactor = SupportInteractor()
            let presenter = SupportPresenter(
                interactor: interactor,
                router: router
            )
            let view = SupportViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
