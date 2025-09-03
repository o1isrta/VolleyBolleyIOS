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
	}
}

// MARK: - Private Methods

private extension NotificationCell {

	func setupUI() {
		selectionStyle = .none
		backgroundColor = AppColor.Background.clear
		contentView.addSubviews(notificationCardView)
		NSLayoutConstraint.activate([
			notificationCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
			notificationCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			notificationCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			notificationCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
		])
	}
}
