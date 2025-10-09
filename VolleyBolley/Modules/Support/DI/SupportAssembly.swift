//
//  SupportAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import Swinject

final class SupportAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SupportViewController.self) { resolver in
            let faqViewController = { resolver.resolve(FAQViewController.self) }
            let router = SupportRouter(faqViewController: faqViewController)
            let presenter = SupportPresenter(
                router: router
            )
            let view = SupportViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
