//
//  AboutAssembly.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import Swinject

final class AboutAssembly: Assembly {

	func assemble(container: Container) {
		container.register(AboutViewProtocol.self) { _ in
			let router = AboutRouter()
			let presenter = AboutPresenter(
				router: router
			)
			let view = AboutViewController(presenter: presenter)

			router.attachViewController(view)
			presenter.view = view

			return view
		}
	}
}
