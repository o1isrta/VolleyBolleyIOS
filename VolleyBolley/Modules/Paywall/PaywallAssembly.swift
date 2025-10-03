//
//  PaywallAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import Foundation
import Swinject

final class PaywallAssembly: Assembly {

	func assemble(container: Container) {
		container.register(PaywallViewController.self) { _ in
			let paywallVC = PaywallViewController()
			let interactor = PaywallInteractor()
			let router = PaywallRouter(viewController: paywallVC)
			let presenter = PaywallPresenter(interactor: interactor, router: router)

			paywallVC.presenter = presenter
			interactor.presenter = presenter
			presenter.view = paywallVC

			return paywallVC
		}
	}
}
