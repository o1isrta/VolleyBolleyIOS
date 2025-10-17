//
//  NewGameOrTourneyDateCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.10.2025.
//

import UIKit

final class NewGameOrTourneyDateCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "NewGameOrTourneyDateCell"

	// MARK: - Private Properties

	private var callback: (() -> Void)?

	private enum Constants {
		static let maxMessageLength: Int = 160

		static let inset: CGFloat = 16
		static let insetLitle: CGFloat = 8
		static let insetMidle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8

		static let viewHeight: CGFloat = 36

		static let titleFontSize: CGFloat = 20
		static let textFontSize: CGFloat = 16
		static let counterFontSize: CGFloat = 14
	}

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.date.title"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()

	private lazy var todayButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "newGameOrTourney.date.today"), for: .normal)
		button.isSelected = true
		return button
	}()
	private lazy var pickDateButton: GreenButton = {
		let button = GreenButton(imagePlacement: .trailing)
		button.setTitle(String(localized: "newGameOrTourney.date.pickDate"), for: .normal)
		button.setImage(.arrowForward, for: .normal)
		return button
	}()
	private lazy var dateHStackView: UIStackView = {
		todayButton.setContentHuggingPriority(.required, for: .horizontal)
		pickDateButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		let spacer = UIView()
		spacer.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		let stackView = UIStackView(arrangedSubviews: [
			todayButton,
			pickDateButton,
			spacer
		])
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = Constants.stackViewSpacing
		return stackView
	}()
	private lazy var calendarView: UIView = {
		let calendarComponent: CalendarComponentProtocol = CalendarComponent(delegate: self)
		let calendarVC = calendarComponent.createCalendarViewController()
		return calendarVC.view
	}()
	private lazy var dateVStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			dateHStackView,
			calendarView
		])
		stackView.axis = .vertical
		stackView.spacing = Constants.stackViewSpacing
		return stackView
	}()

	private lazy var gameDurationLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.gameDuration"))
		label.font = AppFont.Hero.regular(size: Constants.textFontSize)
		return label
	}()

	private lazy var fromTimeLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.from"))
		label.font = AppFont.Hero.regular(size: Constants.textFontSize)
		return label
	}()
	private lazy var fromTimeButton = TimePickerButton()
	private lazy var toTimeLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.to"))
		label.font = AppFont.Hero.regular(size: Constants.textFontSize)
		return label
	}()
	private lazy var toTimeButton = TimePickerButton()

	private lazy var timeStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			fromTimeLabel,
			fromTimeButton,
			toTimeLabel,
			toTimeButton
		])
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = Constants.stackViewSpacing
		return stackView
	}()

	private lazy var separator = CustomSeparator()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(callback: (() -> Void)?) {
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension NewGameOrTourneyDateCell {

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupViews()
		setupSeparator()
		// TODO: -
		calendarView.isHidden = true
	}

	func setupViews() {
		contentView.addSubviews(
			titleLabel,
			dateVStackView,
			timeStackView,
			gameDurationLabel
		)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			dateVStackView.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.insetMidle
			),
			dateVStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			dateVStackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			),

			gameDurationLabel.topAnchor.constraint(
				equalTo: dateVStackView.bottomAnchor,
				constant: Constants.insetMidle
			),
			gameDurationLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			timeStackView.topAnchor.constraint(
				equalTo: gameDurationLabel.bottomAnchor,
				constant: Constants.insetLitle
			),
			timeStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			timeStackView.trailingAnchor.constraint(
				lessThanOrEqualTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			)
		])
	}

	func setupSeparator() {
		contentView.addSubviews(separator)
		NSLayoutConstraint.activate([
			separator.topAnchor.constraint(
				equalTo: timeStackView.bottomAnchor,
				constant: Constants.inset
			),
			separator.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			separator.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			),
			separator.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Constants.inset
			)
		])
	}
}

// MARK: - CalendarComponentDelegate

extension NewGameOrTourneyDateCell: CalendarComponentDelegate {

	func didSelectDate(_ date: Date) {
		print("Selected date:", date)
	}
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyViewController()
}
#endif
