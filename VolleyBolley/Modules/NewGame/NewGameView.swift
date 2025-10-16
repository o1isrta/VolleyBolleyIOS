//
//  NewGameView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

protocol NewGameViewProtocol: AnyObject {
	func setGetStartedButton(enabled: Bool)
	func updateMessageCount(_ count: Int)
	func updateSelectedLevels(_ titles: [String])
	func updateSelectedGender(_ title: String?)
	func showPlaceholder(_ show: Bool)
	func updateDateSelection(todaySelected: Bool)
	func updateSelectedPlace(_ place: String?)
	func updateSelectedDate(_ date: String?)
}

final class NewGameView: BaseViewController, NewGameViewProtocol {

    var presenter: NewGamePresenterProtocol?

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
        return contentView
    }()

    private lazy var contentBackground: GlassmorphismView = GlassmorphismView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let scrollContentView: UIView = UIView()

    private lazy var getStartedButton: YellowButton = {
        let button = YellowButton(title: String(localized: "GET STARTED"))
        button.isEnabled = false
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
        return view
    }()

    private lazy var messageTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = AppColor.Background.clear
        textView.textColor = AppColor.Text.primary
        textView.font = AppFont.Hero.regular(size: 16)
        textView.textAlignment = .left
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.layer.cornerRadius = 16
        textView.layer.borderColor = AppColor.Border.primary.cgColor
        return textView
    }()

    private lazy var messagePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Leave a note for players...")
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.light(size: 14)
        return label
    }()

    private lazy var messageLettersCounter: UILabel = {
        let counter = UILabel()
        counter.textColor = AppColor.Text.primary
        counter.font = AppFont.Hero.light(size: 14)
        counter.textAlignment = .right
        counter.text = "0/160"
        return counter
    }()

    private lazy var messageSeparator = CustomSeparator()

    private lazy var placeLabel = CustomTitle(text: String(localized: "Place"), isLarge: false)
    private lazy var placeButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Change"), for: .normal)
        button.isSelected = true
        return button
    }()

    private lazy var locationContainerView: UIView = UIView()

    private lazy var locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = AppColor.Icon.location
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var locationName: UILabel = {
        let label = UILabel()
        label.text = "Karon Beach Club"
        label.font = AppFont.Hero.bold(size: 16)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 1
        return label
    }()

    private lazy var locationAddress: UILabel = {
        let label = UILabel()
        label.text = "Patak Rd, Mueang Phuket"
        label.font = AppFont.Hero.light(size: 14)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 1
        return label
    }()

    private lazy var locationStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			locationName,
			locationAddress
		])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var placeSeparator = CustomSeparator()
    private lazy var dateLabel = CustomTitle(text: String(localized: "Date"), isLarge: false)

    private lazy var todayButton: GreenButton = {
        let button = GreenButton()
        button.setTitle(String(localized: "Today"), for: .normal)
        button.isSelected = true
        return button
    }()

    private lazy var pickDateButton: GreenButton = {
        let button = GreenButton(imagePlacement: .trailing)
        button.setTitle(String(localized: "Pick date"), for: .normal)
        button.setImage(.arrowForward, for: .normal)
        return button
    }()

    private lazy var gameDurationLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Game duration")
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        return label
    }()

    private lazy var fromTimeLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "from")
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        return label
    }()
    private lazy var fromTimeButton = TimePickerButton()

    private lazy var toTimeLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "to")
        label.font = AppFont.Hero.regular(size: 16)
        label.textColor = AppColor.Text.primary
        return label
    }()
    private lazy var toTimeButton = TimePickerButton()

    private lazy var dateStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			fromTimeLabel, fromTimeButton, toTimeLabel, toTimeButton
		])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
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
        messageTextField.delegate = self
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        setupScrollView()
        setupLabelView()
        setupMessageTextField()
        setupLocationView()
        setupDateView()
        setupGenderView()
        setupLevelView()
        setupActions()
    }

    private func setupScrollView() {
        view.addSubviews(contentView)
        contentView.addSubviews(contentBackground)
        contentBackground.addSubviews(scrollView)
        scrollView.addSubviews(scrollContentView)

        NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
			contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -315),

            contentBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: contentBackground.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor),

            scrollContentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupLabelView() {
		scrollContentView.addSubviews(
			backButton,
			titleLabel
		)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 18),
            backButton.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor)
        ])
    }

    private func setupMessageTextField() {
		scrollContentView.addSubviews(
			yourMessageTitle,
			messageTextView,
			messageSeparator
		)
		messageTextView.addSubviews(
			messageTextField,
			messagePlaceholderLabel,
			messageLettersCounter
		)
        NSLayoutConstraint.activate([
            yourMessageTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            yourMessageTitle.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            messageTextView.topAnchor.constraint(equalTo: yourMessageTitle.bottomAnchor, constant: 16),
            messageTextView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            messageTextView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
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
            messageSeparator.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            messageSeparator.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20)
        ])
    }

    private func setupLocationView() {
		scrollContentView.addSubviews(
			placeLabel,
			placeButton,
			placeSeparator
		)
        locationContainerView.addSubviews(
			locationIcon,
			locationStackView
		)
        scrollContentView.addSubview(locationContainerView)

        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: messageSeparator.bottomAnchor, constant: 16),
            placeLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            placeButton.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 12),
            placeButton.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -26),

            placeSeparator.topAnchor.constraint(equalTo: placeButton.bottomAnchor, constant: 16),
            placeSeparator.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            placeSeparator.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),

            locationContainerView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 12),
            locationContainerView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
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
		scrollContentView.addSubviews(
			dateLabel,
			todayButton,
			pickDateButton,
			gameDurationLabel,
			dateSeparator,
			dateStackView
		)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: placeSeparator.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            todayButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            todayButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            pickDateButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            pickDateButton.leadingAnchor.constraint(equalTo: todayButton.trailingAnchor, constant: 20),

            gameDurationLabel.topAnchor.constraint(equalTo: todayButton.bottomAnchor, constant: 12),
            gameDurationLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: gameDurationLabel.bottomAnchor, constant: 8),
            dateStackView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            dateSeparator.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 16),
            dateSeparator.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            dateSeparator.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20)
        ])
    }

    private func setupGenderView() {
		scrollContentView.addSubviews(
			genderLabel,
			mixGenderButton,
			maleGenderButton,
			femaleGenderButton,
			genderSeparator
		)

        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: dateSeparator.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            mixGenderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 12),
            mixGenderButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            maleGenderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 12),
            maleGenderButton.leadingAnchor.constraint(equalTo: mixGenderButton.trailingAnchor, constant: 20),

            femaleGenderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 12),
            femaleGenderButton.leadingAnchor.constraint(equalTo: maleGenderButton.trailingAnchor, constant: 20),

            genderSeparator.topAnchor.constraint(equalTo: mixGenderButton.bottomAnchor, constant: 16),
            genderSeparator.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            genderSeparator.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20)
        ])
    }

    private func setupLevelView() {
        [playerLevelLabel, lightLevelButton, mediumLevelButton,
         hardLevelButton, proLevelButton, getStartedButton]
            .forEach {
                scrollContentView.addSubviews($0)
            }

        NSLayoutConstraint.activate([
            playerLevelLabel.topAnchor.constraint(equalTo: genderSeparator.bottomAnchor, constant: 16),
            playerLevelLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            lightLevelButton.topAnchor.constraint(equalTo: playerLevelLabel.bottomAnchor, constant: 12),
            lightLevelButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),

            mediumLevelButton.centerYAnchor.constraint(equalTo: lightLevelButton.centerYAnchor),
            mediumLevelButton.leadingAnchor.constraint(equalTo: lightLevelButton.trailingAnchor, constant: 8),

            hardLevelButton.centerYAnchor.constraint(equalTo: mediumLevelButton.centerYAnchor),
            hardLevelButton.leadingAnchor.constraint(equalTo: mediumLevelButton.trailingAnchor, constant: 8),

            proLevelButton.centerYAnchor.constraint(equalTo: hardLevelButton.centerYAnchor),
            proLevelButton.leadingAnchor.constraint(equalTo: hardLevelButton.trailingAnchor, constant: 8),

            getStartedButton.topAnchor.constraint(equalTo: proLevelButton.bottomAnchor, constant: 16),
            getStartedButton.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -20),
            getStartedButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            getStartedButton.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            getStartedButton.heightAnchor.constraint(equalToConstant: 56)
            ])
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        getStartedButton.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
        placeButton.addTarget(self, action: #selector(didTapPlace), for: .touchUpInside)
        todayButton.addTarget(self, action: #selector(didTapDate), for: .touchUpInside)
        pickDateButton.addTarget(self, action: #selector(didTapDate), for: .touchUpInside)
        mixGenderButton.addTarget(self, action: #selector(didTapGender), for: .touchUpInside)
        maleGenderButton.addTarget(self, action: #selector(didTapGender), for: .touchUpInside)
        femaleGenderButton.addTarget(self, action: #selector(didTapGender), for: .touchUpInside)
        lightLevelButton.addTarget(self, action: #selector(didTapLevel), for: .touchUpInside)
        mediumLevelButton.addTarget(self, action: #selector(didTapLevel), for: .touchUpInside)
        hardLevelButton.addTarget(self, action: #selector(didTapLevel), for: .touchUpInside)
        proLevelButton.addTarget(self, action: #selector(didTapLevel), for: .touchUpInside)
    }

    @objc private func didTapBack() { presenter?.didTapBack() }
    @objc private func didTapGetStarted() { presenter?.didTapGetStarted() }
    @objc private func didTapPlace() {
        // TODO: Добавить выбор места проведения игры
    }

    @objc private func didTapDate(_ sender: GreenButton) {
        if sender == todayButton {
            todayButton.isSelected = true
            pickDateButton.isSelected = false
            presenter?.didSelectDateButton("Today")
        } else if sender == pickDateButton {
            pickDateButton.isSelected = true
            todayButton.isSelected = false
            presenter?.didSelectDateButton("Pick date")
        }
    }

    @objc private func didTapGender(_ sender: GreenButton) {
        [mixGenderButton, maleGenderButton, femaleGenderButton].forEach { $0.isSelected = false }
        sender.isSelected = true
        presenter?.didToggleGender(sender.title(for: .normal) ?? "")
    }

    @objc private func didTapLevel(_ sender: GreenButton) {
        sender.isSelected.toggle()
        presenter?.didToggleLevel(sender.title(for: .normal) ?? "")
    }

    func setGetStartedButton(enabled: Bool) {
        getStartedButton.isEnabled = enabled
        getStartedButton.isSelected = enabled
    }

    func updateMessageCount(_ count: Int) {
        messageLettersCounter.text = "\(count)/160"
    }

    func updateSelectedLevels(_ titles: [String]) {
        [lightLevelButton, mediumLevelButton, hardLevelButton, proLevelButton].forEach
        { $0.isSelected = titles.contains($0.title(for: .normal) ?? "") }
    }

    func updateSelectedGender(_ title: String?) {
        [mixGenderButton, maleGenderButton, femaleGenderButton].forEach
        { $0.isSelected = $0.title(for: .normal) == title }
    }

    func showPlaceholder(_ show: Bool) {
        messagePlaceholderLabel.isHidden = !show
    }

    func updateSelectedDate(_ date: String?) {
        // TODO: Функционал выбора даты игры
    }

    func updateDateSelection(todaySelected: Bool) {
        todayButton.isSelected = todaySelected
        pickDateButton.isSelected = !todaySelected
    }

    func updateSelectedPlace(_ place: String?) {
        locationName.text = place ?? "Choose place"
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 160
    }
}

extension NewGameView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        messagePlaceholderLabel.isHidden = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        messagePlaceholderLabel.isHidden = !textView.text.isEmpty
    }

    func textViewDidChange(_ textView: UITextView) {
        messageLettersCounter.text = "\(textView.text.count)/160"
        messagePlaceholderLabel.isHidden = !textView.text.isEmpty
        presenter?.didChangeMessage(textView.text)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    NewGameView()
}
#endif
