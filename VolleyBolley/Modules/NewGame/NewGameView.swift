//
//  NewGameView.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 24.07.2025.
//

import UIKit

final class NewGameView: BaseViewController, NewGameViewProtocol {

    var presenter: UserRegPresenterProtocol?

    private lazy var navigationBarView = CustomNavBarView()
    private lazy var mainTabBarController = MainTabBarController()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = AppColor.Background.screen
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentBackground: GlassmorphismView = {
        let view = GlassmorphismView()
        return view
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var backButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel = CustomTitle(text: String(localized: "Create a game"), isLarge: true)
    private lazy var yourMessageTitle = CustomTitle(text: String(localized: "Your message"), isLarge: false)

    private lazy var messageTextView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.blur
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(localized: "Leave a note for players...")
        textField.attributedPlaceholder = NSAttributedString(
            string: "Leave a note for players...",
            attributes: [
                .foregroundColor: AppColor.Text.placeHolder,
                .font: AppFont.Hero.light(size: 14)
            ]
        )
        textField.backgroundColor = AppColor.Background.clear
        textField.textColor = AppColor.Text.primary
        textField.setLeftPaddingPoints(16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var messageLettersCounter: UILabel = {
        let counter = UILabel()
        counter.textColor = AppColor.Text.primary
        counter.font = AppFont.Hero.light(size: 14)
        counter.textAlignment = .right
        counter.text = "0/160"
        counter.translatesAutoresizingMaskIntoConstraints = false
        return counter
    }()

    private lazy var messageSeparator = CustomSeparator()

    private lazy var placeLabel = CustomLabel(text: String(localized: "Place"), isBold: true)
    private lazy var placeButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Place"), for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(placeButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var placeSeparator = CustomSeparator()

    private lazy var dateLabel = CustomLabel(text: String(localized: "Date"), isBold: true)

    private lazy var todayButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Today"), for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var pickDateButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Pick date") + " → ", for: .normal)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var gameDurationLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Game duration")
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var fromTimeButton = TimePickerButton()
    private lazy var toTimeButton = TimePickerButton()

    private lazy var dateSeparator = CustomSeparator()

    private lazy var genderLabel = CustomLabel(text: String(localized: "Gender"), isBold: true)
    private lazy var mixGenderButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Mix"), for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var maleGenderButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Man"), for: .normal)
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var femaleGenderButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Women"), for: .normal)
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var genderSeparator = CustomSeparator()

    private lazy var playerLevelLabel = CustomLabel(text: String(localized: "Player level"), isBold: true)

    private lazy var lightLevelButton = PickButton(
        title: String(localized: "common.light").capitalized(with: .current),
        isSelected: true,
        target: self,
        action: #selector(levelButtonTapped)
    )
    private lazy var mediumLevelButton = PickButton(
        title: String(localized: "common.medium").capitalized(with: .current),
        isSelected: false,
        target: self,
        action: #selector(levelButtonTapped)
    )
    private lazy var hardLevelButton = PickButton(
        title: String(localized: "common.hard").capitalized(with: .current),
        isSelected: false,
        target: self,
        action: #selector(levelButtonTapped)
    )
    private lazy var proLevelButton = PickButton(
        title: String(localized: "common.pro").capitalized(with: .current),
        isSelected: false,
        target: self,
        action: #selector(levelButtonTapped)
    )

    private lazy var getStartedButton = NextStepButton(
        title: String(localized: "GET STARTED"),
        isActive: false,
        target: self,
        action: #selector(getStartedTapped)
    )

    private var selectedGender: String? = String(localized: "Mix")
    private var selectedLevel: String? = String(localized: "common.light").capitalized(with: .current)
    private var selectedDate: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupUI()
        setupActions()

        //        startNewGame.setTitle("NEXT STEP", for: .normal)
        //        startNewGame.setState(.inactive)
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        view.addSubview(navigationBarView)
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false

        addChild(mainTabBarController)
        view.addSubview(mainTabBarController.view)
        mainTabBarController.didMove(toParent: self)
        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentView)
        scrollView.addSubview(contentBackground)
        scrollView.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 106),

            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -8),
            contentView.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor, constant: -8),

            contentBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            getStartedButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            getStartedButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 8),
            getStartedButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -8),

            mainTabBarController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTabBarController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTabBarController.view.heightAnchor.constraint(equalToConstant: 81)
        ])
    }

    private func setupUI() {
        [backButton, titleLabel, yourMessageTitle, messageTextView, messageSeparator,
         placeLabel, placeButton, placeSeparator, dateLabel, todayButton, pickDateButton,
         gameDurationLabel,fromTimeButton, toTimeButton, dateSeparator, genderLabel, mixGenderButton, maleGenderButton,
         femaleGenderButton, genderSeparator, playerLevelLabel, lightLevelButton, mediumLevelButton, hardLevelButton,
         proLevelButton
        ]
            .forEach {
                contentView.addSubviews($0)
            }

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 18),
            backButton.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            yourMessageTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            yourMessageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            messageTextView.topAnchor.constraint(equalTo: yourMessageTitle.bottomAnchor, constant: 16),
            messageTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            messageTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            messageTextView.heightAnchor.constraint(equalToConstant: 106),

            messageSeparator.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 16),
            messageSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            messageSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            placeLabel.topAnchor.constraint(equalTo: messageSeparator.bottomAnchor, constant: 16),
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            placeButton.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 12),
            placeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),

            placeSeparator.topAnchor.constraint(equalTo: placeButton.bottomAnchor, constant: 16),
            placeSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            placeSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            dateLabel.topAnchor.constraint(equalTo: placeSeparator.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            todayButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            todayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            pickDateButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            pickDateButton.leadingAnchor.constraint(equalTo: todayButton.trailingAnchor, constant: 20),

            gameDurationLabel.topAnchor.constraint(equalTo: todayButton.bottomAnchor, constant: 12),
            gameDurationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            fromTimeButton.topAnchor.constraint(equalTo: gameDurationLabel.bottomAnchor, constant: 12),
            fromTimeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            toTimeButton.topAnchor.constraint(equalTo: gameDurationLabel.bottomAnchor, constant: 12),
            toTimeButton.leadingAnchor.constraint(equalTo: fromTimeButton.trailingAnchor, constant: 20),

            dateSeparator.topAnchor.constraint(equalTo: fromTimeButton.bottomAnchor, constant: 16),
            dateSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            genderLabel.topAnchor.constraint(equalTo: dateSeparator.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            mixGenderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 12),
            mixGenderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            maleGenderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 12),
            maleGenderButton.leadingAnchor.constraint(equalTo: mixGenderButton.trailingAnchor, constant: 20),

            femaleGenderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 12),
            femaleGenderButton.leadingAnchor.constraint(equalTo: maleGenderButton.trailingAnchor, constant: 20),

            genderSeparator.topAnchor.constraint(equalTo: mixGenderButton.bottomAnchor, constant: 16),
            genderSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            playerLevelLabel.topAnchor.constraint(equalTo: genderSeparator.bottomAnchor, constant: 16),
            playerLevelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            lightLevelButton.topAnchor.constraint(equalTo: playerLevelLabel.bottomAnchor, constant: 12),
            lightLevelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            mediumLevelButton.centerYAnchor.constraint(equalTo: lightLevelButton.centerYAnchor),
            mediumLevelButton.leadingAnchor.constraint(equalTo: lightLevelButton.trailingAnchor, constant: 8),

            hardLevelButton.centerYAnchor.constraint(equalTo: mediumLevelButton.centerYAnchor),
            hardLevelButton.leadingAnchor.constraint(equalTo: mediumLevelButton.trailingAnchor, constant: 8),

            proLevelButton.centerYAnchor.constraint(equalTo: hardLevelButton.centerYAnchor),
            proLevelButton.leadingAnchor.constraint(equalTo: hardLevelButton.trailingAnchor, constant: 8),
        ])

        [messageTextField,
         messageLettersCounter
        ]
            .forEach {
                messageTextView.addSubviews($0)
            }

        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: messageTextView.topAnchor, constant: 16),
            messageTextField.leadingAnchor.constraint(equalTo: messageTextView.leadingAnchor, constant: 16),
            messageTextField.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor, constant: -16),
            messageTextField.heightAnchor.constraint(equalToConstant: 57),

            messageLettersCounter.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor, constant: -16),
            messageLettersCounter.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: -16)
        ])
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        messageTextField.addTarget(self, action: #selector(messageTextFieldChanged), for: .editingChanged)
    }

    @objc private func didTapBack() {
        dismiss(animated: true)
    }

    @objc private func placeButtonTapped() {
        print("Выбрано новое место")
    }

    @objc private func dateButtonTapped() {
        print("Выбрано новая дата игры")
    }

    @objc private func genderButtonTapped(_ sender: PickButton) {
        print("Выбран пол игроков")
        [mixGenderButton, maleGenderButton, femaleGenderButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        selectedGender = sender.title(for: .normal)
    }

    @objc private func levelButtonTapped(_ sender: PickButton) {
        print("Выбран уровень игроков")
        [lightLevelButton, mediumLevelButton, hardLevelButton, proLevelButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        selectedLevel = sender.title(for: .normal)
    }

    @objc private func getStartedTapped() {
        print("Создаем игру")
    }

    @objc private func messageTextFieldChanged() {
        let text = messageTextField.text ?? ""
        messageLettersCounter.text = "\(text.count)/160"
        getStartedButton.setActive(!text.isEmpty)
    }

    func updateDate(_ date: String) {

    }

    func updatePlace(_ place: String) {

    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    NewGameView()
}
#endif
