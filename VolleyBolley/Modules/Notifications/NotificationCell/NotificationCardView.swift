//
//  NotificationCardView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.08.2025.
//

import UIKit

struct NotificationCardViewModel: Equatable, Codable {
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
		self.date = AppDateFormatters.onlyDate.string(from: date)
	}
	// TODO: mock data
	static var mockDataArray = [
		NotificationCardViewModel(
			title: "New invite",
			message: "Anton Ivanov invited you",
			date: Date()
		),
		NotificationCardViewModel(
			title: "Removed from tourney",
			message: "12 September, 2:00-8:00 pm",
			date: Date()
		),
		NotificationCardViewModel(
			title: "Tourney removed from your calendar",
			message: "12 September, 2:00-8:00 pm. You can create new tourney",
			date: Date()
		)
	]
}

final class NotificationCardView: UIView {

	// MARK: - Private Properties

	private lazy var backgroundView = GlassmorphismView(configuration: .notification)
	private lazy var titleLabel: GradientLabel = {
		let label = GradientLabel()
		label.font = AppFont.Hero.bold(size: 16)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 0
		return label
	}()
	private lazy var messageLabel = CustomLabel(text: "")
	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(
			arrangedSubviews: [
				textStackView,
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

	private lazy var textStackView: UIStackView = {
		titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
		let stackView = UIStackView(
			arrangedSubviews: [
				titleLabel,
				dateLabel
			]
		)
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.alignment = .top
		stackView.spacing = 4
		return stackView
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(with model: NotificationCardViewModel) {
		backgroundView.resetForReuse()
		titleLabel.text = model.title
		messageLabel.text = model.message
		dateLabel.text = model.date
	}
}

// MARK: - Private Methods

private extension NotificationCardView {

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

			mainStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: mainInset),
			mainStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: mainInset),
			mainStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -mainInset),
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
		let model = NotificationCardViewModel.mockDataArray[0]
		let view = NotificationCardView()
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()

	UIViewPreview {
		let model = NotificationCardViewModel.mockDataArray[1]
		let view = NotificationCardView()
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
