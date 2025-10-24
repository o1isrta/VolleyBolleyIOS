//
//  EditPhotoAssembly.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 21.09.2025.
//

import Swinject

final class EditPhotoAssembly: Assembly {

    func assemble(container: Container) {
        container.register(EditProfilePhotoViewController.self) { _ in
            let view = EditProfilePhotoViewController()
            let router = EditProfilePhotoRouter(view: view)
            let interactor = EditProfilePhotoInteractor(view: view)
            let presenter = EditProfilePhotoPresenter(
                view: view,
                interactor: interactor,
                router: router
            )
            view.presenter = presenter
            router.attachViewController(view)

            return view
        }
    }
}
