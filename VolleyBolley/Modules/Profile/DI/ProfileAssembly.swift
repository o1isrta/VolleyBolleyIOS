//
//  ProfileAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class ProfileAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ProfileViewController.self) { resolver in
            guard
                let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self)
            else {
                fatalError("Error: Failed to register ProfileViewController")
            }

			let personalDataViewController = { resolver.resolve(PersonalDataViewController.self) }
			let supportViewController = { resolver.resolve(SupportViewController.self) }
			let aboutViewController = { resolver.resolve(AboutViewController.self) }
			let faqViewController = { resolver.resolve(FAQViewController.self) }

			let router = ProfileRouter(
				personalDataViewController: personalDataViewController,
				supportViewController: supportViewController,
				aboutViewController: aboutViewController,
				faqViewController: faqViewController
			)

            let interactor = ProfileInteractor(
                imageLoader: imageLoader
            )

            let presenter = ProfilePresenter(
                interactor: interactor,
                router: router
            )

            let view = ProfileViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
