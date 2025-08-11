//
//  CourtDescriptionView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import UIKit

// MARK: - CourtDescriptionViewModel

struct CourtDescriptionViewModel {
	let price: String
	let description: String
	let contact: String

	init(price: String?, description: String?, contact: String?) {
		self.price = price ?? "-"
		self.description = description ?? ""
		self.contact = contact ?? "-"
	}
}

final class CourtDescriptionView: UIView {

	// MARK: - Private Properties

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

	func configure(with model: CourtDescriptionViewModel) {
		priceLabel.setTextWithDifferentStyles([
			(String(localized: "Court pricing: "), AppFont.ActayWide.bold(size: 16)),
			(model.price, AppFont.Hero.regular(size: 16))
		])
		descriptionLabel.text = model.description
		contactLabel.setTextWithDifferentStyles([
			(String(localized: "Contacts: "), AppFont.ActayWide.bold(size: 16)),
			(model.contact, AppFont.Hero.regular(size: 16))
		])
	}
}

// MARK: - Private Methods

private extension CourtDescriptionView {

	func setupUI() {
		[
			priceLabel,
			descriptionLabel,
			contactLabel
		].forEach {
			descriptionStackView.addArrangedSubview($0)
		}

		addSubviews(descriptionStackView)

		NSLayoutConstraint.activate([
			descriptionStackView.topAnchor.constraint(equalTo: topAnchor),
			descriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			descriptionStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let view = CourtDescriptionView()
		let courtModel = CourtModel.mockData
		let model = CourtDescriptionViewModel(
			price: courtModel.price,
			description: courtModel.description,
			contact: courtModel.contacts?[0].value
		)
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 111)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
