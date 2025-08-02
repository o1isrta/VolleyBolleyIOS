//
//  CourtView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

final class CourtView: UIView {

	// MARK: - Private Properties

	private let courtImageView = CourtImageView()

	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 16// TODO
		imageView.backgroundColor = .systemGray5// TODO
		return imageView
	}()

	private lazy var priceLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		return label
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 3
		return label
	}()

	private lazy var contactLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		return label
	}()

	private lazy var chooseButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Choose this court", for: .normal)
		button.backgroundColor = .systemBlue// TODO
		button.setTitleColor(.white, for: .normal)// TODO
		button.layer.cornerRadius = 12// TODO
		return button
	}()

	private lazy var descriptionStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 8
		return stackView
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(with court: CourtModel, isSmallDoneButton: Bool = false) {
		if isSmallDoneButton {
			chooseButton.widthAnchor.constraint(equalToConstant: 215).isActive = true
			chooseButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = false
		} else {
			chooseButton.widthAnchor.constraint(equalToConstant: 215).isActive = false
			chooseButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		}

		priceLabel.setTextWithDifferentStyles([
			(String(localized: "Court pricing: "), AppFont.ActayWide.bold(size: 16)),
			(court.price ?? "-", AppFont.Hero.regular(size: 16))
		])
		descriptionLabel.text = court.description
		contactLabel.setTextWithDifferentStyles([
			(String(localized: "Contacts: "), AppFont.ActayWide.bold(size: 16)),
			(court.contacts?[0].value ?? "-", AppFont.Hero.regular(size: 16))
		])
		if let url = court.imageUrl {
			// Здесь можно добавить асинхронную загрузку изображения
			imageView.backgroundColor = .systemGray4
		} else {
			imageView.backgroundColor = .systemGray4
		}
	}
}

private extension CourtView {

	private func setupUI() {
		[
			courtImageView,
			priceLabel,
			descriptionLabel,
			contactLabel
		].forEach {
			descriptionStack.addArrangedSubview($0)
		}

		addSubviews(
			descriptionStack,
			chooseButton
		)

		NSLayoutConstraint.activate([
			courtImageView.heightAnchor.constraint(equalToConstant: 193),

			descriptionStack.topAnchor.constraint(equalTo: topAnchor),
			descriptionStack.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionStack.trailingAnchor.constraint(equalTo: trailingAnchor),

			chooseButton.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 16),
			chooseButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			chooseButton.heightAnchor.constraint(equalToConstant: 44),
			chooseButton.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

#if DEBUG
import SwiftUI
import UIKit
// Обертка для UIView
struct UIViewPreview<View: UIView>: UIViewRepresentable {
	let view: View

	init(_ builder: @escaping () -> View) {
		view = builder()
	}

	// MARK: - UIViewRepresentable
	func makeUIView(context: Context) -> View {
		return view
	}

	func updateUIView(_ uiView: View, context: Context) {
		uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
		uiView.setContentHuggingPriority(.defaultLow, for: .vertical)
	}
}

@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let view = CourtView()
		// swiftlint:disable line_length
		let model = CourtModel(
			id: 1,
			price: "$20/hour",
			description: "A beautiful court in the heart of Central Park. Recently renovated, with night lighting and locker rooms.",
			contacts: [
				ContactModel(
					type: "PHONE",
					value: "+1 212-555-1234"
				)
			],
			imageUrl: nil,
			tagList: [
				"4 courts",
				"Outdoor"
			],
			location: CourtLocationModel(
				latitude: 40.785091,
				longitude: -73.968285,
				courtName: "Central Park Court",
				locationName: "USA, New York"
			)
		)
		// swiftlint:enable line_length
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 472)
	.padding()
}
#endif
