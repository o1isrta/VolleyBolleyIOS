//
//  PersonalDataViewController.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

final class PersonalDataViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let mainIndent: CGFloat = 8
        static let mediumIndent: CGFloat = 10
        static let mediumSpacing: CGFloat = 16
        static let mainSpacing: CGFloat = 20
        static let tabBarHeight: CGFloat = 81
        static let backButtonTopInset: CGFloat = 14
        static let profileImageSize: CGFloat = 122
        static let editButtonSize: CGFloat = 24
        static let buttonHeight: CGFloat = 51
        static let birthdayTextFieldWidth: CGFloat = 120
        static let birthdayTextFieldLeftPadding: CGFloat = 0
    }

    // MARK: - Private Properties

    private let presenter: PersonalDataPresenterProtocol

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var glassmorphismView = GlassmorphismView()

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

    private lazy var profileContainerView = UIView()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Icon.profile
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        let pencilImage = UIImage.Icon.pencil.withRenderingMode(.alwaysOriginal)
        button.setImage(pencilImage, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
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
        return stack
    }()
    private lazy var surnameSeparator = CustomSeparator()

    // Gender field

    private lazy var genderLabel = CustomLabel(text: String(localized: "Gender"), isBold: true)
    private lazy var maleButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Male"), for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var femaleButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Female"), for: .normal)
        button.isSelected = false
        button.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
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
        field.delegate = self
        return field
    }()
    private lazy var birthdayStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [birthdayLabel, birthdayTextField])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = Constants.mainIndent
        return stack
    }()
    private let birthdaySeparator = CustomSeparator()

    // Country field

    private lazy var countryLabel = CustomLabel(text: String(localized: "Your country"), isBold: true)
    private var countryList: LocationPickerView?
    private lazy var countryStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryLabel, countryList ?? UIView()])
        stack.axis = .vertical
        stack.spacing = Constants.mainIndent
        return stack
    }()
    private lazy var countrySeparator = CustomSeparator()

    // City field

    private lazy var cityLabel = CustomLabel(text: String(localized: "Your city"), isBold: true)
    private var cityList: LocationPickerView?
    private lazy var cityStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel, cityList ?? UIView()])
        stack.axis = .vertical
        stack.spacing = Constants.mainIndent
        return stack
    }()

    private lazy var updateButton: YellowButton = {
        let button = YellowButton()
        button.isSelected = true
        button.setTitle(String(localized: "Update").uppercased(), for: .normal)
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Form Stack
    private lazy var formStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
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
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = Constants.mediumSpacing
        stack.setCustomSpacing(Constants.mainIndent, after: profileContainerView)
        return stack
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
        view.backgroundColor = AppColor.Background.screen

        let countries = presenter.countries
        countryList = LocationPickerView(items: countries, placeholder: String(localized: "Choose your country"))
        countryList?.delegate = self

        let cities = presenter.cities
        cityList = LocationPickerView(items: cities, placeholder: String(localized: "Choose your city"))
        cityList?.delegate = self

        setupView()
        presenter.viewDidLoad()
    }
}

// MARK: - Private methods

private extension PersonalDataViewController {

    func setupView() {
        setupScrollView()
        setupSubviews()
        setupConstraints()
    }

    func setupScrollView() {
        view.addSubviews(glassmorphismView)
        glassmorphismView.addSubviews(backButton, screenTitle, scrollView)
        scrollView.addSubviews(contentView)
    }

    func setupSubviews() {
        contentView.addSubviews(formStackView)
        profileContainerView.addSubviews(profileImageView, editButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            glassmorphismView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            glassmorphismView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.mainIndent),
            glassmorphismView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.mainIndent),
            glassmorphismView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.tabBarHeight),

            backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.backButtonTopInset),
            backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: Constants.mediumIndent),

            screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
            screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: Constants.mainSpacing),

            scrollView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: Constants.mediumSpacing),
            scrollView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: glassmorphismView.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            formStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            formStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.mainSpacing),
            formStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.mainSpacing),
            formStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.mainSpacing),

            // Form Constraints

            profileContainerView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileContainerView.widthAnchor.constraint(equalTo: formStackView.widthAnchor),

            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.centerXAnchor.constraint(equalTo: profileContainerView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: profileContainerView.topAnchor),

            editButton.widthAnchor.constraint(equalToConstant: Constants.editButtonSize),
            editButton.heightAnchor.constraint(equalToConstant: Constants.editButtonSize),
            editButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -Constants.mediumIndent),
            editButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -Constants.mainIndent),

            birthdayTextField.widthAnchor.constraint(equalToConstant: Constants.birthdayTextFieldWidth),

            updateButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
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
        [maleButton, femaleButton].forEach { $0.isSelected = false }
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
        guard textField == birthdayTextField else { return true }

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        guard let formattedText = updatedText.formattedBirthdayOrNil() else {
            return false
        }

        textField.text = formattedText
        return false
    }
}

extension PersonalDataViewController: PersonalDataViewProtocol {
    func updateCountries(_ countries: [String]) {
        countryList?.updateItems(countries)
    }
}

extension PersonalDataViewController: LocationPickerViewDelegate {
    func locationPickerView(_ pickerView: LocationPickerView, didSelectItem item: String) {
        if pickerView == countryList {
            selectedCountry = item
        } else if pickerView == cityList {
            selectedCity = item
        }
    }
}

#if DEBUG
import SwiftUI

struct  PersonalDataViewControllerPreview: UIViewControllerRepresentable {
    class StubPresenter: PersonalDataPresenterProtocol {
        let countries: [String] = ["Cyprus", "Thailand"]
        let cities: [String] = ["Koh Phangan", "Koh Samui"]
        weak var view: PersonalDataViewProtocol?
        func viewDidLoad() {}
        func backButtonTapped() {}
        func updateButtonTapped() {}
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let presenter = StubPresenter()
        return PersonalDataViewController(presenter: presenter)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct PersonalDataViewController_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
