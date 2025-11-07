//
//  PersonalDataAssembly.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import Swinject

final class PersonalDataAssembly: Assembly {

    func assemble(container: Container) {
        container.register(PersonalDataViewProtocol.self) { resolver in
			let editProfilePhotoViewController = { resolver.resolve(EditProfilePhotoViewController.self) }
			let router = PersonalDataRouter(
				editProfilePhotoViewController: editProfilePhotoViewController
			)
            let interactor = PersonalDataInteractor()

            let presenter = PersonalDataPresenter(
                interactor: interactor,
                router: router
            )
            let view = PersonalDataViewController(presenter: presenter)
			interactor.presenter = presenter
            presenter.view = view
            router.attachViewController(view)

            return view
        }
    }
}
