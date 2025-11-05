//
//  FAQPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.10.2025.
//

import Foundation

protocol FAQPresenterProtocol: AnyObject {
	var numberOfItems: Int { get }
	func item(at index: Int) -> FAQItem
    func viewDidLoad()
    func didTapBackButton()
}

final class FAQPresenter: FAQPresenterProtocol {

    // MARK: - Public Properties

    weak var view: FAQViewProtocol?

	var numberOfItems: Int { faqItems.count }

    // MARK: - Private Properties

    private let interactor: FAQInteractorProtocol
    private let router: FAQRouterProtocol
    private var faqItems: [FAQItem] = []

    // MARK: - Initializers

    init(
        interactor: FAQInteractorProtocol,
        router: FAQRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

	func item(at index: Int) -> FAQItem {
		return faqItems[index]
	}

    func viewDidLoad() {
        faqItems = interactor.fetchFAQItems()
		view?.reloadTableView()
    }

    func didTapBackButton() {
        router.goBack()
    }
}
