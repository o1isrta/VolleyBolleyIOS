//
//  CourtView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

enum CourtViewType: CaseIterable {
	case oneSmallButton
	case oneBigButton
	case twoButton
}

final class CourtView: UIView {

	// MARK: - Private Properties

	private lazy var courtImageView = CourtImageView()

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

	private lazy var descriptionStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 8
		return stackView
	}()

	private lazy var chooseButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Choose this court", for: .normal)
		button.backgroundColor = .systemBlue// TODO
		button.setTitleColor(.white, for: .normal)// TODO
		button.layer.cornerRadius = 12// TODO
		return button
	}()

	private lazy var detailsButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Details", for: .normal)
		button.backgroundColor = .gray// TODO
		button.setTitleColor(.white, for: .normal)// TODO
		button.layer.cornerRadius = 12// TODO
		button.isHidden = true
		return button
	}()

	private lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.alignment = .leading
		stackView.distribution = .fill
		stackView.addArrangedSubview(chooseButton)
		stackView.addArrangedSubview(detailsButton)
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

	func configure(with court: CourtModel, courtViewType: CourtViewType = .oneBigButton) {
		setupCourtView(type: courtViewType)

		priceLabel.setTextWithDifferentStyles([
			(String(localized: "Court pricing: "), AppFont.ActayWide.bold(size: 16)),
			(court.price ?? "-", AppFont.Hero.regular(size: 16))
		])
		descriptionLabel.text = court.description
		contactLabel.setTextWithDifferentStyles([
			(String(localized: "Contacts: "), AppFont.ActayWide.bold(size: 16)),
			(court.contacts?[0].value ?? "-", AppFont.Hero.regular(size: 16))
		])

		courtImageView.configure(with: court)
	}
}

private extension CourtView {

	private func setupCourtView(type courtViewType: CourtViewType) {
		switch courtViewType {
		case .oneBigButton:
			buttonStackView.widthAnchor.constraint(equalToConstant: 215).isActive = false
			buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
			detailsButton.isHidden = true
		case .oneSmallButton:
			buttonStackView.widthAnchor.constraint(equalToConstant: 215).isActive = true
			buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = false
			detailsButton.isHidden = true
		case .twoButton:
			chooseButton.widthAnchor.constraint(equalToConstant: 205).isActive = true
			detailsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
			detailsButton.isHidden = false
		}
	}

	private func setupUI() {
		[
			courtImageView,
			priceLabel,
			descriptionLabel,
			contactLabel
		].forEach {
			descriptionStackView.addArrangedSubview($0)
		}

		addSubviews(
			descriptionStackView,
			buttonStackView
		)

		NSLayoutConstraint.activate([
			courtImageView.heightAnchor.constraint(equalToConstant: 193),

			descriptionStackView.topAnchor.constraint(equalTo: topAnchor),
			descriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor),

			chooseButton.heightAnchor.constraint(equalToConstant: 44),
			detailsButton.heightAnchor.constraint(equalToConstant: 44),

			buttonStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 16),
			buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
	.padding()
	.frame(width: .infinity, height: 416)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
