//
//  PersonalDataViewController.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

protocol PersonalDataViewControllerProtocol: AnyObject {

}

final class PersonalDataViewController: BaseViewController, PersonalDataViewControllerProtocol {

    // MARK: - Private Properties

    private let presenter: PersonalDataPresenterProtocol

    private lazy var glassmorphismView = GlassmorphismView()
    private lazy var screenTitle = CustomTitle(
        text: String(localized: "personalData.screenTitle"),
        isLarge: true
    )
    private lazy var backButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()


    // MARK: - Initializers

    init(presenter: PersonalDataPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

}

// MARK: - Private methods

private extension PersonalDataViewController {

    @objc
    func backButtonTapped() {
        presenter.backButtonTapped()
    }

    func setupView() {
        view.addSubviews(
            glassmorphismView,
            backButton,
            screenTitle
        )

        let mainIndent: CGFloat = 8
        let mainSpacing: CGFloat = 20

        NSLayoutConstraint.activate([
            glassmorphismView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: mainIndent),
            glassmorphismView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: mainIndent),
            glassmorphismView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -mainIndent),
            glassmorphismView.heightAnchor.constraint(equalToConstant: 400), // убрать

            backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: 14),
            backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainSpacing / 2),

            screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
            screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: mainSpacing)
        ])
    }
}
