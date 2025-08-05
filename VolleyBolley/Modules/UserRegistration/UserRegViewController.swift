//
//  UserRegView.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import UIKit

class UserRegViewController: UIViewController, UITextFieldDelegate {

    var presenter: UserRegPresenterProtocol?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = AppColor.Background.blur
        scrollView.layer.cornerRadius = 32
        scrollView.layer.masksToBounds = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var titleLabel = CustomTitle(text: String(localized: "Registration"), isLarge: true)

    private lazy var nameLabel = CustomLabel(text: String(localized: "Name"), isBold: true)
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(localized: "Anton")
        textField.backgroundColor = AppColor.Border.primary
        textField.layer.cornerRadius = 16
        textField.textColor = AppColor.Text.placeHolder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(16)
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
        title: String(localized: "Light"),
        isSelected: true,
        target: self,
        action: #selector(levelButtonTapped(_:))
    )
    private lazy var mediumLevelButton = PickButton(
        title: String(localized: "Medium"),
        isSelected: false,
        target: self,
        action: #selector(levelButtonTapped(_:))
    )
    private lazy var hardLevelButton = PickButton(
        title: String(localized: "Hard"),
        isSelected: false,
        target: self,
        action: #selector(levelButtonTapped(_:))
    )
    private lazy var proLevelButton = PickButton(
        title: String(localized: "Pro"),
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
        isActive: true,
        target: self,
        action: #selector(getStartedTapped)
    )

    private var selectedGender: String? = String(localized: "Male")
    private var selectedLevel: String? = String(localized: "Light")
    private var selectedCountry: String?
    private var selectedCity: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen

        let countries = presenter?.countries ?? []
        countryList = LocationPickerView(items: countries, placeholder: String(localized: "Choose your country"))
        countryList?.delegate = self

        let cities = presenter?.cities ?? []
        cityList = LocationPickerView(items: cities, placeholder: String(localized: "Choose your city"))
        cityList?.delegate = self

        setupScrollView()
        setupSubviews()
        setupConstraints()
        setupActions()

        presenter?.viewDidLoad()

        view.layoutIfNeeded()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupSubviews() {
        let subviews = [
            titleLabel, nameLabel, nameTextField,
            surnameLabel, surnameTextField, surnameSeparator,
            genderLabel, maleButton, femaleButton, genderSeparator,
            birthdayLabel, birthdayTextField, birthdaySeparator,
            levelLabel, levelInfoButton, lightLevelButton, mediumLevelButton, hardLevelButton,
            proLevelButton, levelSeparator, countryLabel, countryList,
            countrySeparator, cityLabel, cityList, getStartedButton
        ]

        subviews.compactMap { $0 }.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    private func setupConstraints() {
        guard let countryList = countryList else { return }
        guard let cityList = cityList else { return }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 51),

            surnameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            surnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 8),
            surnameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            surnameTextField.heightAnchor.constraint(equalToConstant: 51),

            surnameSeparator.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 16),
            surnameSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            surnameSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            genderLabel.topAnchor.constraint(equalTo: surnameSeparator.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            maleButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            maleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            femaleButton.centerYAnchor.constraint(equalTo: maleButton.centerYAnchor),
            femaleButton.leadingAnchor.constraint(equalTo: maleButton.trailingAnchor, constant: 16),

            genderSeparator.topAnchor.constraint(equalTo: maleButton.bottomAnchor, constant: 16),
            genderSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            birthdayLabel.topAnchor.constraint(equalTo: genderSeparator.bottomAnchor, constant: 16),
            birthdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8),
            birthdayTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            birthdayTextField.widthAnchor.constraint(equalToConstant: 120),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 51),

            birthdaySeparator.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 16),
            birthdaySeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            birthdaySeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            levelLabel.topAnchor.constraint(equalTo: birthdaySeparator.bottomAnchor, constant: 16),
            levelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            levelInfoButton.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor),
            levelInfoButton.leadingAnchor.constraint(equalTo: levelLabel.trailingAnchor, constant: 8),
            levelInfoButton.widthAnchor.constraint(equalToConstant: 17.45),
            levelInfoButton.heightAnchor.constraint(equalToConstant: 17.45),

            lightLevelButton.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 12),
            lightLevelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            mediumLevelButton.centerYAnchor.constraint(equalTo: lightLevelButton.centerYAnchor),
            mediumLevelButton.leadingAnchor.constraint(equalTo: lightLevelButton.trailingAnchor, constant: 8),

            hardLevelButton.centerYAnchor.constraint(equalTo: mediumLevelButton.centerYAnchor),
            hardLevelButton.leadingAnchor.constraint(equalTo: mediumLevelButton.trailingAnchor, constant: 8),

            proLevelButton.centerYAnchor.constraint(equalTo: hardLevelButton.centerYAnchor),
            proLevelButton.leadingAnchor.constraint(equalTo: hardLevelButton.trailingAnchor, constant: 8),

            levelSeparator.topAnchor.constraint(equalTo: lightLevelButton.bottomAnchor, constant: 16),
            levelSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            levelSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            countryLabel.topAnchor.constraint(equalTo: levelSeparator.bottomAnchor, constant: 16),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            countryList.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 12),
            countryList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            countrySeparator.topAnchor.constraint(equalTo: countryList.bottomAnchor, constant: 16),
            countrySeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countrySeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            cityLabel.topAnchor.constraint(equalTo: countrySeparator.bottomAnchor, constant: 16),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            cityList.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            cityList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            getStartedButton.topAnchor.constraint(equalTo: cityList.bottomAnchor, constant: 16),
            getStartedButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            getStartedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            getStartedButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func setupActions() {
        levelInfoButton.addTarget(self, action: #selector(levelInfoButtonTapped), for: .touchUpInside)
    }

    @objc private func genderButtonTapped(_ sender: PickButton) {
        [maleButton, femaleButton].forEach { $0.updateSelectionState(false) }
        sender.updateSelectionState(true)
        selectedGender = sender.title(for: .normal)
    }

    @objc private func levelInfoButtonTapped() {
        presenter?.didTapLevelInfo()
    }

    @objc private func levelButtonTapped(_ sender: PickButton) {
        [lightLevelButton,
         mediumLevelButton,
         hardLevelButton,
         proLevelButton].forEach {
            $0.updateSelectionState(false)
        }

        sender.updateSelectionState(true)
        selectedLevel = sender.title(for: .normal)
    }

    @objc private func getStartedTapped() {
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let gender = selectedGender ?? ""
        presenter?.didTapGetStarted(name: name, surname: surname, gender: gender)
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard textField == birthdayTextField else { return true }

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        let digitsOnly = updatedText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        if digitsOnly.count > 8 {
            return false
        }

        var formattedText = ""
        let dayEnd = min(2, digitsOnly.count)
        if dayEnd > 0 {
            let day = String(digitsOnly.prefix(dayEnd))
            formattedText += day
            if dayEnd == 2 {
                formattedText += " / "
            }
        }

        let monthStart = 2
        let monthEnd = min(4, digitsOnly.count)
        if monthEnd > monthStart {
            let startIdx = digitsOnly.index(digitsOnly.startIndex, offsetBy: monthStart)
            let endIdx = digitsOnly.index(digitsOnly.startIndex, offsetBy: monthEnd)
            let month = String(digitsOnly[startIdx..<endIdx])
            formattedText += month
            if monthEnd == 4 {
                formattedText += " / "
            }
        }

        let yearStart = 4
        if digitsOnly.count > yearStart {
            let startIdx = digitsOnly.index(digitsOnly.startIndex, offsetBy: yearStart)
            let year = String(digitsOnly[startIdx...])
            formattedText += year
        }

        if digitsOnly.count >= 2 {
            if let dayInt = Int(digitsOnly.prefix(2)), dayInt < 1 || dayInt > 31 {
                return false
            }
        }
        if digitsOnly.count >= 4 {
            let monthRange = digitsOnly.index(digitsOnly.startIndex, offsetBy: 2)..<digitsOnly.index(digitsOnly.startIndex, offsetBy: 4)
            if let monthInt = Int(digitsOnly[monthRange]), monthInt < 1 || monthInt > 12 {
                return false
            }
        }
        if digitsOnly.count == 8 {
            let yearRange = digitsOnly.index(digitsOnly.startIndex, offsetBy: 4)..<digitsOnly.index(digitsOnly.startIndex, offsetBy: 8)
            if let yearInt = Int(digitsOnly[yearRange]) {
                let currentYear = Calendar.current.component(.year, from: Date())
                if yearInt > currentYear {
                    return false
                }
            }
        }

        textField.text = formattedText
        return false
    }
}

extension UserRegViewController: UserRegViewProtocol {
    func updateCountries(_ countries: [String]) {
        countryList?.updateItems(countries)
    }
}

extension UserRegViewController: LocationPickerViewDelegate {
    func locationPickerView(_ pickerView: LocationPickerView, didSelectItem item: String) {
        if pickerView == countryList {
            selectedCountry = item
        } else if pickerView == cityList {
            selectedCity = item
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    UserRegViewController()
}
#endif
