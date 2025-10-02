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
    private lazy var glassmorphismView = GlassmorphismView()
    private lazy var formView = PersonalDataFormView()

    private var selectedGender: String? = String(localized: "Male")
    private var selectedCountry: String?
    private var selectedCity: String?

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
        setupData()
        setupView()
        setupActions()
		hideKeyboardWhenTappedAround()
        presenter.viewDidLoad()
    }
}

// MARK: - Private methods

private extension PersonalDataViewController {

    func setupData() {
        let countries = presenter.countries
        let cities = presenter.cities

        formView.countryList.updateItems(countries)
        formView.cityList.updateItems(cities)
        formView.countryList.delegate = self
        formView.cityList.delegate = self
    }

    func setupView() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        view.addSubviews(glassmorphismView)
        glassmorphismView.addSubviews(backButton, screenTitle, scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(formView)
    }

    func setupConstraints() {
        let bottomIndent = Constants.tabBarHeight + Constants.mainIndent

        NSLayoutConstraint.activate([
            glassmorphismView.topAnchor
                .constraint(equalTo: navBar.bottomAnchor, constant: Constants.mainIndent),
            glassmorphismView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: Constants.mainIndent),
            glassmorphismView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -Constants.mainIndent),
            glassmorphismView.bottomAnchor
                .constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -bottomIndent),

            backButton.topAnchor
                .constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.backButtonTopInset),
            backButton.leadingAnchor
                .constraint(equalTo: glassmorphismView.leadingAnchor, constant: Constants.mediumIndent),

            screenTitle.centerXAnchor
                .constraint(equalTo: glassmorphismView.centerXAnchor),
            screenTitle.topAnchor
                .constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.mainSpacing),

            scrollView.topAnchor
                .constraint(equalTo: screenTitle.bottomAnchor, constant: Constants.mediumSpacing),
            scrollView.leadingAnchor
                .constraint(equalTo: glassmorphismView.leadingAnchor),
            scrollView.trailingAnchor
                .constraint(equalTo: glassmorphismView.trailingAnchor),
            scrollView.bottomAnchor
                .constraint(equalTo: glassmorphismView.bottomAnchor),

            contentView.topAnchor
                .constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor
                .constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor
                .constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor
                .constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor
                .constraint(equalTo: scrollView.widthAnchor),

            formView.topAnchor
                .constraint(equalTo: contentView.topAnchor),
            formView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: Constants.mainSpacing),
            formView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -Constants.mainSpacing),
            formView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -Constants.mainSpacing),
        ])

        let minHeight = glassmorphismView.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.contentLayoutGuide.heightAnchor,
            constant: screenTitle.intrinsicContentSize.height + (Constants.mainSpacing * 2)
        )
        minHeight.priority = .defaultHigh
        minHeight.isActive = true
    }

    func setupActions() {
        formView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        formView.maleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        formView.femaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        formView.updateButton.addTarget(self, action: #selector(updateButtonTapped(_:)), for: .touchUpInside)

        formView.birthdayTextField.delegate = self
    }

    @objc
    func backButtonTapped() {
        presenter.backButtonTapped()
    }

    @objc
    func editButtonTapped() {
        // TODO: Редактирование фото профиля
    }

    @objc
    func genderButtonTapped(_ sender: UIButton) {
        [formView.maleButton, formView.femaleButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        selectedGender = sender.title(for: .normal)
    }

    @objc
    func updateButtonTapped(_ sender: UIButton) {
        presenter.updateButtonTapped()
    }
}

extension PersonalDataViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard textField == formView.birthdayTextField else { return true }
        return textField.updateFormattedText(
            range: range,
            replacementString: string,
            formatter: { $0.formattedBirthdayOrNil() }
        )
    }
}

extension PersonalDataViewController: PersonalDataViewProtocol {
    func updateCountries(_ countries: [String]) {
        formView.countryList.updateItems(countries)
    }
}

extension PersonalDataViewController: LocationPickerViewDelegate {
    func locationPickerView(_ pickerView: LocationPickerView, didSelectItem item: String) {
        if pickerView == formView.countryList {
            selectedCountry = item
        } else if pickerView == formView.cityList {
            selectedCity = item
        }
    }
}
