//
//  PersonalDataViewController.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

final class PersonalDataViewController: BaseViewController {

    // MARK: - Constants

    private enum Constants {
        static let mainIndent: CGFloat = 8
        static let mediumIndent: CGFloat = 10
        static let mediumSpacing: CGFloat = 16
        static let mainSpacing: CGFloat = 20
        static let tabBarHeight: CGFloat = 81
        static let backButtonTopInset: CGFloat = 14
    }

    // MARK: - Private Properties

    private let presenter: PersonalDataPresenterProtocol

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let glassView = GlassView()
    private lazy var formView = PersonalDataFormView()

	// TODO: пока решили убрать возможность изменения пола через ЛК, возможно после запуска MVP вернуть придется
	/*
    private var selectedGender: String? = String(localized: "gender.male")
	*/
    private var selectedCountry: String?
    private var selectedCity: String?
    private var selectedBirthday: String?

    private lazy var screenTitle = CustomTitle(
        text: String(localized: "Personal data"),
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
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupFormView()
		hideKeyboardWhenTappedAround()
        presenter.viewDidLoad()
    }
}

extension PersonalDataViewController: PersonalDataViewProtocol {

    func updateCountries(_ countries: [String]) {
        formView.updateCountries(countries)
    }

	func updateUserData(_ image: UIImage) {
		formView.updateUserData(image)
	}
}

// MARK: - Private methods

private extension PersonalDataViewController {

    func setupView() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        view.addSubviews(glassView)
        glassView.addSubviews(backButton, screenTitle, scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(formView)
    }

    func setupFormView() {
        let actions = UserFormActions(
            onEditTapped: handleEditTapped,
			// TODO: пока решили убрать возможность изменения пола через ЛК, возможно после запуска MVP вернуть придется
			/*
            onGenderChanged: handleGenderChanged,
			*/
            onBirthdayChanged: handleBirthdayChanged,
            onCountrySelected: handleCountrySelected,
            onCitySelected: handleCitySelected,
            onUpdateTapped: handleUpdateTapped
        )

        formView.configure(
			userData: presenter.userData,
			countries: presenter.countries,
            cities: presenter.cities,
            actions: actions
        )
    }

    func setupConstraints() {
        let bottomIndent = Constants.tabBarHeight + Constants.mainIndent

        NSLayoutConstraint.activate([
            glassView.topAnchor
                .constraint(equalTo: navBar.bottomAnchor, constant: Constants.mainIndent),
            glassView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: Constants.mainIndent),
            glassView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -Constants.mainIndent),
            glassView.bottomAnchor
                .constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -bottomIndent),

            backButton.topAnchor
                .constraint(equalTo: glassView.topAnchor, constant: Constants.backButtonTopInset),
            backButton.leadingAnchor
                .constraint(equalTo: glassView.leadingAnchor, constant: Constants.mediumIndent),

            screenTitle.centerXAnchor
                .constraint(equalTo: glassView.centerXAnchor),
            screenTitle.topAnchor
                .constraint(equalTo: glassView.topAnchor, constant: Constants.mainSpacing),

            scrollView.topAnchor
                .constraint(equalTo: screenTitle.bottomAnchor, constant: Constants.mediumSpacing),
            scrollView.leadingAnchor
                .constraint(equalTo: glassView.leadingAnchor),
            scrollView.trailingAnchor
                .constraint(equalTo: glassView.trailingAnchor),
            scrollView.bottomAnchor
                .constraint(equalTo: glassView.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            formView.topAnchor
                .constraint(equalTo: contentView.topAnchor),
            formView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: Constants.mainSpacing),
            formView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -Constants.mainSpacing),
            formView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -Constants.mainSpacing)
        ])

        let minHeight = glassView.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.contentLayoutGuide.heightAnchor,
            constant: screenTitle.intrinsicContentSize.height + (Constants.mainSpacing * 2)
        )
        minHeight.priority = .defaultHigh
        minHeight.isActive = true
    }

    // Form callbacks

	func handleEditTapped(_ image: UIImage?) {
		presenter.editProfilePhoto(image: image)
    }

	// TODO: пока решили убрать возможность изменения пола через ЛК, возможно после запуска MVP вернуть придется
	/*
    func handleGenderChanged(_ gender: String) {
        selectedGender = gender
    }
	*/

    func handleBirthdayChanged(_ birthday: String) {
        selectedBirthday = birthday
    }

    func handleCountrySelected(_ country: String) {
        selectedCountry = country
    }

    func handleCitySelected(_ city: String) {
        selectedCity = city
    }

    func handleUpdateTapped() {
        presenter.updateButtonTapped()
    }

    @objc
    func backButtonTapped() {
        presenter.backButtonTapped()
    }
}

#if DEBUG

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	let router = PersonalDataRouter(editProfilePhotoViewController: { nil })
	let interactor = PersonalDataInteractor()
	let presenter = PersonalDataPresenter(
		interactor: interactor,
		router: router
	)
	let view = PersonalDataViewController(presenter: presenter)
	presenter.view = view
	router.attachViewController(view)

	return view
}
#endif
