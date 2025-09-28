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
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var contentBackground: GlassmorphismView = {
        let view = GlassmorphismView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var getStartedButton: YellowButton = {
        let button = YellowButton(title: String(localized: "GET STARTED"))
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var backButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
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

    private lazy var messageTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = AppColor.Background.clear
        textView.textColor = AppColor.Text.primary
        textView.font = AppFont.Hero.regular(size: 16)
        textView.textAlignment = .left
        textView.isScrollEnabled = true
        textView.layer.cornerRadius = 12
        textView.layer.borderColor = AppColor.Border.primary.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var messagePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Leave a note for players...")
        label.textColor = AppColor.Text.placeHolder
        label.font = AppFont.Hero.light(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    private lazy var placeLabel = CustomTitle(text: String(localized: "Place"), isLarge: false)
    private lazy var placeButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Change"), for: .normal)
        button.isSelected = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var locationContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = AppColor.Icon.primary
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var locationName: UILabel = {
        let label = UILabel()
        label.text = "Karon Beach Club"
        label.font = AppFont.Hero.bold(size: 16)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationAddress: UILabel = {
        let label = UILabel()
        label.text = "Patak Rd, Mueang Phuket"
        label.font = AppFont.Hero.light(size: 14)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var placeSeparator = CustomSeparator()

    private lazy var dateLabel = CustomTitle(text: String(localized: "Date"), isLarge: false)

    private lazy var todayButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Today"), for: .normal)
        button.isSelected = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var pickDateButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Pick date") + " → ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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

    private lazy var fromTimeLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "from")
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var fromTimeButton = TimePickerButton()

    private lazy var toTimeLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "to")
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var toTimeButton = TimePickerButton()

    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var dateSeparator = CustomSeparator()

    private lazy var genderLabel = CustomTitle(text: String(localized: "Gender"), isLarge: false)
    private lazy var mixGenderButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Mix"), for: .normal)
        button.isSelected = true
        return button
    }()

    private lazy var maleGenderButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Man"), for: .normal)
        return button
    }()

    private lazy var femaleGenderButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Women"), for: .normal)
        return button
    }()
    private lazy var genderSeparator = CustomSeparator()

    private lazy var playerLevelLabel = CustomTitle(text: String(localized: "Player level"), isLarge: false)

    private lazy var lightLevelButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "common.light"), for: .normal)
        button.isSelected = true
        return button
    }()

    private lazy var mediumLevelButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "common.medium"), for: .normal)
        button.isSelected = true
        return button
    }()

    private lazy var hardLevelButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "common.hard"), for: .normal)
        button.isSelected = true
        return button
    }()

    private lazy var proLevelButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "common.pro"), for: .normal)
        return button
    }()

    private var selectedGender: String? = String(localized: "Mix")
    private var selectedLevel: String? = String(localized: "common.light").capitalized(with: .current)
    private var selectedDate: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupScrollView()
        setupLabelView()
        setupMessageTextField()
        messageTextField.delegate = self
        setupLocationView()
        setupDateView()
        setupGenderView()
        setupLevelView()
        setupActions()
    }

    private func setupScrollView() {
        view.addSubview(navigationBarView)
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        addChild(mainTabBarController)
        view.addSubview(mainTabBarController.view)
        mainTabBarController.didMove(toParent: self)
        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentView)
        contentView.addSubview(contentBackground)
        scrollView.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 106),

            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -81),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -8),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -16),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 739),

            contentBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            getStartedButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            getStartedButton.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            getStartedButton.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            getStartedButton.heightAnchor.constraint(equalToConstant: 56),
            getStartedButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),

            mainTabBarController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTabBarController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTabBarController.view.heightAnchor.constraint(equalToConstant: 81)
        ])
    }

    private func setupLabelView() {
        [backButton, titleLabel]
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
        ])
    }

    private func setupMessageTextField() {
        [yourMessageTitle, messageTextView, messageSeparator]
            .forEach {
                contentView.addSubviews($0)
            }

        [messageTextField, messagePlaceholderLabel, messageLettersCounter]
            .forEach {
                messageTextView.addSubviews($0)
            }

        NSLayoutConstraint.activate([
            yourMessageTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            yourMessageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            messageTextView.topAnchor.constraint(equalTo: yourMessageTitle.bottomAnchor, constant: 16),
            messageTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            messageTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            messageTextView.heightAnchor.constraint(equalToConstant: 106),

            messageTextField.topAnchor.constraint(equalTo: messageTextView.topAnchor, constant: 16),
            messageTextField.leadingAnchor.constraint(equalTo: messageTextView.leadingAnchor, constant: 16),
            messageTextField.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor, constant: -16),
            messageTextField.heightAnchor.constraint(equalToConstant: 57),

            messagePlaceholderLabel.topAnchor.constraint(equalTo: messageTextView.topAnchor, constant: 16),
            messagePlaceholderLabel.leadingAnchor.constraint(equalTo: messageTextView.leadingAnchor, constant: 16),
            messagePlaceholderLabel.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor, constant: -16),

            messageLettersCounter.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor, constant: -16),
            messageLettersCounter.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: -16),

            messageSeparator.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 16),
            messageSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            messageSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    private func setupLocationView() {
        [placeLabel, placeButton, placeSeparator]
            .forEach {
                contentView.addSubviews($0)
            }

        locationStackView.addArrangedSubview(locationName)
        locationStackView.addArrangedSubview(locationAddress)

        locationContainerView.addSubview(locationIcon)
        locationContainerView.addSubview(locationStackView)

        contentView.addSubview(locationContainerView)

        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: messageSeparator.bottomAnchor, constant: 16),
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            placeButton.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 12),
            placeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),

            placeSeparator.topAnchor.constraint(equalTo: placeButton.bottomAnchor, constant: 16),
            placeSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            placeSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            locationContainerView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 12),
            locationContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationContainerView.trailingAnchor.constraint(lessThanOrEqualTo: placeButton.leadingAnchor, constant: -23),

            locationIcon.leadingAnchor.constraint(equalTo: locationContainerView.leadingAnchor),
            locationIcon.centerYAnchor.constraint(equalTo: locationContainerView.centerYAnchor),
            locationIcon.widthAnchor.constraint(equalToConstant: 15),
            locationIcon.heightAnchor.constraint(equalToConstant: 15),

            locationStackView.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8),
            locationStackView.trailingAnchor.constraint(equalTo: locationContainerView.trailingAnchor),
            locationStackView.topAnchor.constraint(equalTo: locationContainerView.topAnchor),
            locationStackView.bottomAnchor.constraint(equalTo: locationContainerView.bottomAnchor)
        ])
    }

    private func setupDateView() {
        [dateLabel, todayButton, pickDateButton, gameDurationLabel, dateSeparator]
            .forEach {
                contentView.addSubviews($0)
            }

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: placeSeparator.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            todayButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            todayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            pickDateButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            pickDateButton.leadingAnchor.constraint(equalTo: todayButton.trailingAnchor, constant: 20),

            gameDurationLabel.topAnchor.constraint(equalTo: todayButton.bottomAnchor, constant: 12),
            gameDurationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])

        [fromTimeLabel, fromTimeButton, toTimeLabel, toTimeButton]
            .forEach {
                dateStackView.addArrangedSubview($0)
            }

        contentView.addSubview(dateStackView)

        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: gameDurationLabel.bottomAnchor, constant: 8),
            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            dateSeparator.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 16),
            dateSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    private func setupGenderView() {
        [genderLabel, mixGenderButton, maleGenderButton,
         femaleGenderButton, genderSeparator,]
            .forEach {
                contentView.addSubviews($0)
            }

        NSLayoutConstraint.activate([
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
        ])
    }

    private func setupLevelView() {
        [playerLevelLabel, lightLevelButton, mediumLevelButton,
         hardLevelButton, proLevelButton]
            .forEach {
                contentView.addSubviews($0)
            }

        NSLayoutConstraint.activate([
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
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
                todayButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
                pickDateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
                mixGenderButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
                maleGenderButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
                femaleGenderButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
                lightLevelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
                mediumLevelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
                hardLevelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
                proLevelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
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

    @objc private func genderButtonTapped(_ sender: GreenButton) {
        print("Выбран пол игроков")
        [mixGenderButton, maleGenderButton, femaleGenderButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        selectedGender = sender.title(for: .normal)
    }

    @objc private func levelButtonTapped(_ sender: GreenButton) {
        sender.isSelected.toggle()
        var selectedLevels: [String] = []
        [lightLevelButton, mediumLevelButton, hardLevelButton, proLevelButton].forEach { button in
            if button.isSelected, let title = button.title(for: .normal) {
                selectedLevels.append(title)
            }
        }
        selectedLevel = selectedLevels.joined(separator: ", ")
    }

    @objc private func getStartedTapped() {
        print("Создаем игру")
    }

    @objc private func messageTextFieldChanged() {
        let text = messageTextField.text ?? ""
        messageLettersCounter.text = "\(text.count)/160"
        getStartedButton.isEnabled = !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        getStartedButton.isSelected = !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        messagePlaceholderLabel.isHidden = !textView.text.isEmpty
        messageLettersCounter.text = "\(textView.text.count)/160"

        getStartedButton.isEnabled = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        getStartedButton.isSelected = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    NewGameView()
}
#endif
