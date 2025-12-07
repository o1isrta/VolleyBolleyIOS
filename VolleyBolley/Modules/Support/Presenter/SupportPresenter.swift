//
//  SupportPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

import UIKit

// MARK: - SupportPresenterProtocol

protocol SupportPresenterProtocol: AnyObject {
    func backButtonTapped()
    func didSelectSupportItem(_ item: SupportItem)
}

// MARK: - SupportPresenter

final class SupportPresenter: SupportPresenterProtocol {

    // MARK: - Public Properties

    weak var view: SupportViewControllerProtocol?

    // MARK: - Private Properties

    private let router: SupportRouterProtocol

    // MARK: - Initializers

    init(router: SupportRouterProtocol) {
        self.router = router
    }

    // MARK: - Public Methods

    func backButtonTapped() {
        router.navigateBack()
    }

    func didSelectSupportItem(_ item: SupportItem) {
        switch item {
        case .faq:
            router.showFAQ()
        case .linktree:
            openURL(AppConstants.Contacts.linktreeURL)
        case .contactUs:
            view?.sendEmail()
        case .whatsApp:
            openURL(AppConstants.Contacts.whatsAppURL)
        }
    }

    // MARK: - Private Methods

    private func openURL(_ url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
