//
//  NotificationCardView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.08.2025.
//

import UIKit

struct NotificationCardViewModel {
	let title: String
	let message: String
	let date: String

	init(
		title: String,
		message: String,
		date: Date
	) {
		self.title = title
		self.message = message
		self.date = date.formatted(date: .numeric, time: .omitted)
	}
}

final class NotificationCardView: UIView {

	// MARK: - Private Properties

	private let backgroundView = GlassmorphismView(configuration: .notification)

	private lazy var titleLabel = CustomLabel(text: "", isBold: true)
	private lazy var messageLabel = CustomLabel(text: "")
	private lazy var textStackView: UIStackView = {
		let stackView = UIStackView(
			arrangedSubviews: [
				titleLabel,
				messageLabel
			]
		)
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 4
		return stackView
	}()

	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.light(size: 14)
		label.textColor = AppColor.Text.primary
		return label
	}()

	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(
			arrangedSubviews: [
				textStackView,
				dateLabel
			]
		)
		stackView.axis = .horizontal
		stackView.distribution = .fillProportionally
		stackView.alignment = .top
		stackView.spacing = 10
		return stackView
	}()

	// MARK: - Initializers

	init(model: NotificationCardViewModel) {
		super.init(frame: .zero)
		setupUI()
		configure(with: model)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		titleLabel.applyGradient()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }
}

// MARK: - Private Methods

private extension NotificationCardView {

	func configure(with model: NotificationCardViewModel) {
		titleLabel.text = model.title
		messageLabel.text = model.message
		dateLabel.text = model.date
	}

	func setupUI() {
		backgroundColor = AppColor.Background.clear

		addSubviews(
			backgroundView,
			mainStackView
		)

		let mainInset: CGFloat = 16

		NSLayoutConstraint.activate([
			backgroundView.topAnchor.constraint(equalTo: topAnchor),
			backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

			dateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),

			mainStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: mainInset),
			mainStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: mainInset),
			mainStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: mainInset),
			mainStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -mainInset)
		])
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let model = NotificationCardViewModel(
			title: "New invite",
			message: "Anton Ivanov invited you",
			date: Date()
		)
		let view = NotificationCardView(model: model)
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()

	UIViewPreview {
		let model = NotificationCardViewModel(
			title: "Removed from tourney",
			message: "12 September, 2:00-8:00 pm",
			date: Date()
		)
		let view = NotificationCardView(model: model)
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
