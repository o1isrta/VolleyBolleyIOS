//
//  PersonalDataFormView.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 02.10.2025.
//

import UIKit

final class PersonalDataFormView: UIStackView {

    // MARK: - Constants

    private enum Constants {
        static let mainIndent: CGFloat = 8
        static let mediumIndent: CGFloat = 10
        static let mediumSpacing: CGFloat = 16
        static let profileImageSize: CGFloat = 122
        static let birthdayTextFieldLeftPadding: CGFloat = 0
        static let editButtonSize: CGFloat = 24
        static let buttonHeight: CGFloat = 51
        static let birthdayTextFieldWidth: CGFloat = 120
    }

    // MARK: - Private Properties

    private var onEditTapped: (() -> Void)?
    private var onGenderChanged: ((String) -> Void)?
    private var onBirthdayChanged: ((String) -> Void)?
    private var onCountrySelected: ((String) -> Void)?
    private var onCitySelected: ((String) -> Void)?
    private var onUpdateTapped: (() -> Void)?

    private lazy var profileContainerView = UIView()
	private lazy var profileImageView = AvatarImageView()
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        let pencilImage = UIImage.Icon.pencil.withRenderingMode(.alwaysOriginal)
        button.setImage(pencilImage, for: .normal)
        button.clipsToBounds = true
        return button
    }()

    // Name field

    private lazy var nameLabel = CustomLabel(text: String(localized: "Name"), isBold: true)
    private lazy var nameTextField = CustomTextField(
        placeholder: String(localized: "Name")
    )
    private lazy var nameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stack.axis = .vertical
        stack.spacing = Constants.mainIndent
        nameLabel.setRequiredPriorities()
        return stack
    }()

    // Surname field

    private lazy var surnameLabel = CustomLabel(text: String(localized: "Surname"), isBold: true)
    private lazy var surnameTextField = CustomTextField(
        placeholder: String(localized: "Surname")
    )
    private lazy var surnameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [surnameLabel, surnameTextField])
        stack.axis = .vertical
        stack.spacing = Constants.mainIndent
        surnameLabel.setRequiredPriorities()
        return stack
    }()
    private lazy var surnameSeparator = CustomSeparator()

    // Gender field

    private lazy var genderLabel = CustomLabel(text: String(localized: "Gender"), isBold: true)
    private lazy var maleButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Male"), for: .normal)
        button.isSelected = true
        return button
    }()
    private lazy var femaleButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Female"), for: .normal)
        button.isSelected = false
        return button
    }()
    private lazy var genderButtonsStackView: UIStackView = {
        let spacer = UIView()
        spacer.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        let stack = UIStackView(arrangedSubviews: [
            maleButton,
            femaleButton,
            spacer
        ])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = Constants.mainIndent
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private lazy var genderStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [genderLabel, genderButtonsStackView])
        stack.axis = .vertical
        stack.spacing = Constants.mainIndent
        genderLabel.setRequiredPriorities()
        return stack
    }()
    private lazy var genderSeparator = CustomSeparator()

    // Birthday field

    private lazy var birthdayLabel = CustomLabel(text: String(localized: "Date of birth"), isBold: true)
    private lazy var birthdayTextField: CustomTextField = {
        let field = CustomTextField(
            placeholder: "__ / __ / ____",
            alignment: .center,
            keyboardType: .numberPad,
            leftPadding: Constants.birthdayTextFieldLeftPadding
        )
        return field
    }()
    private lazy var birthdayStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [birthdayLabel, birthdayTextField])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = Constants.mainIndent
        birthdayLabel.setRequiredPriorities()
        return stack
    }()
    private lazy var birthdaySeparator = CustomSeparator()

    // Country field

    private lazy var countryLabel = CustomLabel(text: String(localized: "Your country"), isBold: true)
    private lazy var countryList = LocationPickerView(
        items: [],
        placeholder: String(localized: "Choose your country")
    )
    private lazy var countryStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryLabel, countryList])
        stack.axis = .vertical
        stack.spacing = Constants.mainIndent
        countryLabel.setRequiredPriorities()
        return stack
    }()
    private lazy var countrySeparator = CustomSeparator()

    // City field

    private lazy var cityLabel = CustomLabel(text: String(localized: "Your city"), isBold: true)
    private lazy var cityList = LocationPickerView(
        items: [],
        placeholder: String(localized: "Choose your city")
    )
    private lazy var cityStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel, cityList])
        stack.axis = .vertical
        stack.spacing = Constants.mainIndent
        cityLabel.setRequiredPriorities()
        return stack
    }()

    private lazy var updateButton: YellowButton = {
        let button = YellowButton()
        button.isSelected = true
        button.setTitle(String(localized: "Update").uppercased(), for: .normal)
        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(
        countries: [String],
        cities: [String],
        actions: UserFormActions
    ) {
        countryList.updateItems(countries)
        cityList.updateItems(cities)

        onEditTapped = actions.onEditTapped
        onGenderChanged = actions.onGenderChanged
        onBirthdayChanged = actions.onBirthdayChanged
        onCountrySelected = actions.onCountrySelected
        onCitySelected = actions.onCitySelected
        onUpdateTapped = actions.onUpdateTapped

        countryList.delegate = self
        cityList.delegate = self
        birthdayTextField.delegate = self

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(updateButtonTapped(_:)), for: .touchUpInside)
    }

    func updateCountries(_ countries: [String]) {
        countryList.updateItems(countries)
    }
}

extension PersonalDataFormView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard textField == birthdayTextField else { return true }
        return textField.updateFormattedText(
            range: range,
            replacementString: string,
            formatter: { $0.formattedBirthdayOrNil() }
        )
    }
}

extension PersonalDataFormView: LocationPickerViewDelegate {
    func locationPickerView(_ pickerView: LocationPickerView, didSelectItem item: String) {
        if pickerView == countryList {
            onCountrySelected?(item)
        } else if pickerView == cityList {
            onCitySelected?(item)
        }
    }
}

// MARK: - Private Methods

private extension PersonalDataFormView {

    func setupView() {
        axis = .vertical
        alignment = .fill
        spacing = Constants.mediumSpacing
        setCustomSpacing(Constants.mainIndent, after: profileContainerView)
    }

    func setupSubviews() {
        profileContainerView.addSubviews(profileImageView, editButton)

        let fields: [UIView] = [
            profileContainerView,
            nameStackView,
            surnameStackView,
            surnameSeparator,
            genderStackView,
            genderSeparator,
            birthdayStackView,
            birthdaySeparator,
            countryStackView,
            countrySeparator,
            cityStackView,
            updateButton
        ]

        fields.forEach { addArrangedSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileContainerView.heightAnchor
                .constraint(equalToConstant: Constants.profileImageSize),
            profileContainerView.widthAnchor
                .constraint(equalTo: widthAnchor),

            profileImageView.widthAnchor
                .constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor
                .constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.centerXAnchor
                .constraint(equalTo: profileContainerView.centerXAnchor),
            profileImageView.topAnchor
                .constraint(equalTo: profileContainerView.topAnchor),

            editButton.widthAnchor
                .constraint(equalToConstant: Constants.editButtonSize),
            editButton.heightAnchor
                .constraint(equalToConstant: Constants.editButtonSize),
            editButton.trailingAnchor
                .constraint(equalTo: profileImageView.trailingAnchor, constant: -Constants.mediumIndent),
            editButton.bottomAnchor
                .constraint(equalTo: profileImageView.bottomAnchor, constant: -Constants.mainIndent),

            birthdayTextField.widthAnchor
                .constraint(equalToConstant: Constants.birthdayTextFieldWidth),
            updateButton.heightAnchor
                .constraint(equalToConstant: Constants.buttonHeight)
        ])
    }

    @objc func editButtonTapped() {
        onEditTapped?()
    }

    @objc func genderButtonTapped(_ sender: UIButton) {
        [maleButton, femaleButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        if let title = sender.title(for: .normal) {
            onGenderChanged?(title)
        }
    }

    @objc func updateButtonTapped(_ sender: UIButton) {
        onUpdateTapped?()
    }
}

#if DEBUG

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	let router = PersonalDataRouter()
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
