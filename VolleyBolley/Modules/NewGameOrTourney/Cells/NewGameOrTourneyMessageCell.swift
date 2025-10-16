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

	private lazy var yourMessageTitle: CustomLabel = {
//		let label = CustomLabel(text: String(localized: "Your message"), isBold: true)
		let label = CustomLabel(text: "", isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		label.textColor = AppColor.Text.primary
		label.backgroundColor = AppColor.Background.clear
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

// MARK: - Private Properties

private extension NewGameOrTourneyMessageCell {

	enum Constants {
		static let maxMessageLength: Int = 160

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
			yourMessageTitle,
			messageView,
			separator
		)

		NSLayoutConstraint.activate([
			yourMessageTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			yourMessageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

			messageView.topAnchor.constraint(equalTo: yourMessageTitle.bottomAnchor, constant: 16),
			messageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			messageView.heightAnchor.constraint(equalToConstant: 106),

			separator.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 16),
			separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
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
