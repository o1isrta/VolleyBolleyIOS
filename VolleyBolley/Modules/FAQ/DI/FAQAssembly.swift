//
//  FAQAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.10.2025.
//

import Swinject

final class FAQAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FAQViewController.self) { _ in
            let router = FAQRouter()
            let interactor = FAQInteractor()

            let presenter = FAQPresenter(
                interactor: interactor,
                router: router
            )

            let view = FAQViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
