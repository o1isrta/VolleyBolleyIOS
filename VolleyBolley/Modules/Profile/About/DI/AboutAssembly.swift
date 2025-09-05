//
//  AboutAssembly.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import Swinject
import UIKit

final class AboutAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AboutViewController.self) { _ in
            let router = AboutRouter()
            let interactor = AboutInteractor()
            let presenter = AboutPresenter(interactor: interactor, router: router)
            let view = AboutViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
