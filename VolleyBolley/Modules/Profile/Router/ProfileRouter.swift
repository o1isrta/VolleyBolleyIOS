//
//  ProfileRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
	func showPlayersList()
    func showPersonalData()
    func showSupport()
    func showFAQ()
	func showAbout()
}

final class ProfileRouter: ProfileRouterProtocol {

	// MARK: - Public Properties

    weak var viewController: UIViewController?

	// MARK: - Private Properties

	private let playersListViewController: () -> PlayersListViewController?
	private let personalDataViewController: () -> PersonalDataViewController?
	private let supportViewController: () -> SupportViewController?
	private let faqViewController: () -> FAQViewController?
	private let aboutViewController: () -> AboutViewController?

	// MARK: - Initializers

	init(
		playersListViewController: @escaping () -> PlayersListViewController?,
		personalDataViewController: @escaping () -> PersonalDataViewController?,
		supportViewController: @escaping () -> SupportViewController?,
		aboutViewController: @escaping () -> AboutViewController?,
		faqViewController: @escaping () -> FAQViewController?
	) {
		self.playersListViewController = playersListViewController
		self.personalDataViewController = personalDataViewController
		self.supportViewController = supportViewController
		self.aboutViewController = aboutViewController
		self.faqViewController = faqViewController
	}

	// MARK: - Public Methods

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

	func showPlayersList() {
		guard let playersListVC = playersListViewController() else { fatalError("PlayersListViewController could not be created") }
		viewController?.navigationController?.pushViewController(playersListVC, animated: true)
	}

    func showPersonalData() {
		guard let personalDataVC = personalDataViewController() else {
			fatalError("PersonalDataViewController could not be created")
		}
        viewController?.navigationController?.pushViewController(personalDataVC, animated: true)
    }

	func showSupport() {
		guard let supportVC = supportViewController() else { fatalError("SupportViewController could not be created") }
		viewController?.navigationController?.pushViewController(supportVC, animated: true)
    }

	func showAbout() {
		guard let aboutVC = aboutViewController() else { fatalError("AboutViewController could not be created") }
		viewController?.navigationController?.pushViewController(aboutVC, animated: true)
	}

    func showFAQ() {
		guard let faqVC = faqViewController() else { fatalError("FAQViewController could not be created") }
        viewController?.navigationController?.pushViewController(faqVC, animated: true)
    }
}
