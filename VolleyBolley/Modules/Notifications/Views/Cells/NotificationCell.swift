//
//  NotificationCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 02.09.2025.
//

import UIKit

final class NotificationCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "NotificationCell"

	// MARK: - Private Properties

	private let notificationCardView = NotificationCardView()

	private lazy var noNotificationLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.text = String(localized: "notifications.noNotifications")
		label.isHidden = true
		return label
	}()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(with model: NotificationCardViewModel) {
		notificationCardView.configure(with: model)
		noNotificationLabel.isHidden = true
		notificationCardView.isHidden = false
	}

	func configureAsNoNotifications() {
		noNotificationLabel.isHidden = false
		notificationCardView.isHidden = true
	}
}

// MARK: - Private Methods

private extension NotificationCell {

	func setupUI() {
		selectionStyle = .none
		backgroundColor = AppColor.Background.clear

		contentView.addSubviews(
			noNotificationLabel,
			notificationCardView
		)

		NSLayoutConstraint.activate([
			noNotificationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -6),
			noNotificationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

			notificationCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
			notificationCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			notificationCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			notificationCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
		])
	}
}
