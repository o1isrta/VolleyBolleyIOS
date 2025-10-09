//
//  SupportRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import UIKit

// MARK: - SupportRouterProtocol

protocol SupportRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
	func navigateBack()
	func showFAQ()
}

// MARK: - SupportRouter

final class SupportRouter: SupportRouterProtocol {

    // MARK: - Public Properties

    weak var viewController: UIViewController?
	private let faqViewController: () -> FAQViewController?

	// MARK: - Initializers

	init(faqViewController: @escaping () -> FAQViewController?) {
		self.faqViewController = faqViewController
	}

	// MARK: - Public Methods

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func showFAQ() {
		guard let faqVC = faqViewController() else {
			fatalError("FAQViewController could not be created")
		}
		viewController?.navigationController?.pushViewController(faqVC, animated: true)
	}
}
