//
//  NewGameOrTourneyTypeCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 18.10.2025.
//

import UIKit

final class NewGameOrTourneyTypeCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "NewGameOrTourneyTypeCell"

	// MARK: - Private Properties

	private var callback: ((TourneyType) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMidle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8

		static let titleFontSize: CGFloat = 20
	}

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.tourneyType.title"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()
	private lazy var individualButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "newGameOrTourney.tourneyType.individual"), for: .normal)
		button.isSelected = true
		button.addAction(UIAction { [weak self] _ in
			self?.didTourneyTypeChanged(to: .individual)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var teamButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "newGameOrTourney.tourneyType.team"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didTourneyTypeChanged(to: .team)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var stackView: UIStackView = {
		individualButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		teamButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		let stackView = UIStackView(arrangedSubviews: [
			individualButton,
			teamButton
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

	func configure(callback: ((TourneyType) -> Void)?) {
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension NewGameOrTourneyTypeCell {

	func didTourneyTypeChanged(to type: TourneyType) {
		individualButton.isSelected = type == .individual
		teamButton.isSelected = type == .team
		callback?(type)
	}

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupViews()
		setupSeparator()
	}

	func setupViews() {
		contentView.addSubviews(
			titleLabel,
			stackView
		)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			stackView.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.insetMidle
			),
			stackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			stackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			)
		])
	}

	func setupSeparator() {
		contentView.addSubviews(separator)
		NSLayoutConstraint.activate([
			separator.topAnchor.constraint(
				equalTo: stackView.bottomAnchor,
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

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyViewController()
}
#endif
