//
//  PaywallAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import Swinject
import UIKit

final class PaywallAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(with parentViewController: UIViewController?) -> PaywallViewController {
		let paywallVC = PaywallViewController()
		let interactor = PaywallInteractor()
		let router = PaywallRouter(viewController: paywallVC)
		let presenter = PaywallPresenter(interactor: interactor, router: router)

		paywallVC.presenter = presenter
		interactor.presenter = presenter
		presenter.view = paywallVC

		return paywallVC
	}

	// MARK: - Swinject Assembly

	func assemble(container: Container) {
		container.register(PaywallViewController.self) { _ in
			PaywallAssembly.createModule(with: nil)
		}
	}
}
