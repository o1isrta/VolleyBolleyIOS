//
//  NewGameOrTourneyMessageCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

final class NewGameOrTourneyMessageCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "NewGameOrTourneyMessageCell"

	var onMessageChange: ((String) -> Void)?

	// MARK: - Private Properties

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.message.title"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()

	private lazy var messageView: MessageView = MessageView(type: .withCounter)
	private lazy var separator = CustomSeparator()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupCallback()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }
}

// MARK: - Private Methods

private extension NewGameOrTourneyMessageCell {

	enum Constants {
		static let maxMessageLength: Int = 160

		static let inset: CGFloat = 16
		static let insetLarge: CGFloat = 20

		static let viewHeight: CGFloat = 106

		static let titleFontSize: CGFloat = 20
		static let messageFontSize: CGFloat = 16
		static let counterFontSize: CGFloat = 14
	}

	func setupCallback() {
		messageView.onTextChange = { [weak self] text in
			self?.onMessageChange?(text)
		}
	}

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none

		contentView.addSubviews(
			titleLabel,
			messageView,
			separator
		)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Constants.inset
			),
			titleLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			messageView.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.inset
			),
			messageView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			messageView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			),
			messageView.heightAnchor.constraint(equalToConstant: Constants.viewHeight),

			separator.topAnchor.constraint(
				equalTo: messageView.bottomAnchor,
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
