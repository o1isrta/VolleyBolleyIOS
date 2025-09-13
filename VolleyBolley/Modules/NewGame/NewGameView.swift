//
//  NewGameView.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 24.07.2025.
//

import UIKit

final class NewGameView: BaseViewController {

    var presenter: NewGamePresenterProtocol?

        private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.backgroundColor = AppColor.Background.screen
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.showsVerticalScrollIndicator = false
            return scrollView
        }()

        private lazy var contentView: UIView = {
            let contentView = UIView()
            contentView.backgroundColor = AppColor.Background.blur
            contentView.layer.cornerRadius = 32
            contentView.layer.masksToBounds = true
            contentView.translatesAutoresizingMaskIntoConstraints = false
            return contentView
        }()

        private lazy var titleLabel = CustomTitle(text: String(localized: "registration_title"), isLarge: true)
        private lazy var nameLabel = CustomLabel(text: String(localized: "Name"), isBold: true)
        private lazy var nameTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = String(localized: "Anton")
            textField.backgroundColor = AppColor.Border.primary
            textField.layer.cornerRadius = 16
            textField.textColor = AppColor.Text.placeHolder
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.setLeftPaddingPoints(16)
            textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
            return textField
        }()

        private lazy var surnameLabel = CustomLabel(text: String(localized: "Surname"), isBold: true)
        private lazy var surnameTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = String(localized: "Ivanov")
            textField.backgroundColor = AppColor.Border.primary
            textField.layer.cornerRadius = 16
            textField.textColor = AppColor.Text.placeHolder
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.setLeftPaddingPoints(16)
            return textField
        }()
        private lazy var surnameSeparator = CustomSeparator()

        private lazy var genderLabel = CustomLabel(text: String(localized: "Gender"), isBold: true)
        private lazy var maleButton = PickButton(
            title: String(localized: "Male"),
            isSelected: true,
            target: self,
            action: #selector(genderButtonTapped(_:))
        )
        private lazy var femaleButton = PickButton(
            title: String(localized: "Female"),
            isSelected: false,
            target: self,
            action: #selector(genderButtonTapped(_:))
        )
        private lazy var genderSeparator = CustomSeparator()

        private lazy var birthdayLabel = CustomLabel(text: String(localized: "Date of birth"), isBold: true)
        private lazy var birthdayTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "__ / __ / ____"
            textField.textAlignment = .center
            textField.backgroundColor = AppColor.Text.primary
            textField.layer.cornerRadius = 16
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.keyboardType = .numberPad
            textField.textColor = AppColor.Text.placeHolder
            textField.font = AppFont.Hero.regular(size: 16)
            textField.delegate = self
            return textField
        }()
        private let birthdaySeparator = CustomSeparator()

        private lazy var levelLabel = CustomLabel(text: String(localized: "Level"), isBold: true)
        private lazy var levelInfoButton: UIButton = {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(systemName: "questionmark.circle")
            config.imagePlacement = .leading
            config.imagePadding = 0
            config.baseForegroundColor = AppColor.Background.screen
            config.background.backgroundColor = .white
            config.background.cornerRadius = 12

            let button = UIButton(configuration: config)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        private lazy var lightLevelButton = PickButton(
            title: String(localized: "common.light").capitalized(with: .current),
            isSelected: true,
            target: self,
            action: #selector(levelButtonTapped(_:))
        )
        private lazy var mediumLevelButton = PickButton(
            title: String(localized: "common.medium").capitalized(with: .current),
            isSelected: false,
            target: self,
            action: #selector(levelButtonTapped(_:))
        )
        private lazy var hardLevelButton = PickButton(
            title: String(localized: "common.hard").capitalized(with: .current),
            isSelected: false,
            target: self,
            action: #selector(levelButtonTapped(_:))
        )
        private lazy var proLevelButton = PickButton(
            title: String(localized: "common.pro").capitalized(with: .current),
            isSelected: false,
            target: self,
            action: #selector(levelButtonTapped(_:))
        )
        private lazy var levelSeparator = CustomSeparator()

        private lazy var countryLabel = CustomLabel(text: String(localized: "Your country"), isBold: true)
        private var countryList: LocationPickerView?
        private lazy var countrySeparator = CustomSeparator()

        private lazy var cityLabel = CustomLabel(text: String(localized: "Your city"), isBold: true)
        private var cityList: LocationPickerView?

        private lazy var getStartedButton = NextStepButton(
            title: String(localized: "GET STARTED"),
            isActive: false,
            target: self,
            action: #selector(getStartedTapped)
        )

        private var selectedGender: String? = String(localized: "Male")
        private var selectedLevel: String? = String(localized: "common.light").capitalized(with: .current)
        private var selectedCountry: String?
        private var selectedCity: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        setupUI()
        setupActions()

        startNewGame.setTitle("NEXT STEP", for: .normal)
        startNewGame.setState(.inactive)
    }

    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(phoneNumberLabel)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(startNewGame)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22.5),
            backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 18),
            backButton.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            phoneNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            phoneTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 51),

            startNewGame.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            startNewGame.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            startNewGame.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            startNewGame.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        startNewGame.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
    }

    @objc private func phoneNumberDidChange() {
        let phoneNumber = phoneTextField.text ?? ""
//        presenter?.phoneNumberDidChange(phoneNumber)
    }

    @objc private func backTapped() {
//        presenter?.didTapBack()
    }

    @objc private func startGameTapped() {
        let phoneNumber = phoneTextField.text ?? ""
//        presenter?.didTapNextStep(with: phoneNumber)
    }
}



@available(iOS 17.0, *)
#Preview {
    NewGameView()
}
