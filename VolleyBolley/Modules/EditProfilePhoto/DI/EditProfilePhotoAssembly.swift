//
//  EditProfilePhotoAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import Swinject

final class EditProfilePhotoAssembly: Assembly {

	func assemble(container: Container) {
		container.register(EditProfilePhotoViewController.self) { _ in
			let view = EditProfilePhotoViewController()
			let router = EditProfilePhotoRouter()
			let interactor = EditProfilePhotoInteractor()
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
