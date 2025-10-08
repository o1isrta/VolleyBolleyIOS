//
//  SupportPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.10.2025.
//

// MARK: - SupportPresenterProtocol

protocol SupportPresenterProtocol: AnyObject {
    func viewDidLoad()
	func backButtonTapped()
	func faqTapped()
}

// MARK: - SupportPresenter

final class SupportPresenter: SupportPresenterProtocol {

	// MARK: - Public Properties

    weak var view: SupportViewControllerProtocol?
    private let interactor: SupportInteractorProtocol
    private let router: SupportRouterProtocol

    // MARK: - Initializers

    init(interactor: SupportInteractorProtocol, router: SupportRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

	// MARK: - Public Methods

    func viewDidLoad() {}

	func backButtonTapped() {
		router.navigateBack()
	}

	func faqTapped() {
		router.showFAQ()
	}
}
