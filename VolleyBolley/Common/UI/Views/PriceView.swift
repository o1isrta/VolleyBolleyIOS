//
//  PriceView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 23.08.2025.
//

import UIKit

final class PriceView: GlassmorphismView {

	// MARK: - Private Properties

	private lazy var priceLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.textAlignment = .center
		return label
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

	func configure(value: String) {
		priceLabel.text = value
	}
}

// MARK: - Private Methods

private extension PriceView {

	func setupUI() {
		cornerRadius = 16
		blurIntensity = 0.1
		innerShadowOpacity = 0.2

		addSubviews(priceLabel)

		NSLayoutConstraint.activate([
			priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5.5),
			priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27.5),
			priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27.5),
			priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.5)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let view = PriceView()
		view.configure(value: "5$")
		return view
	}
	.frame(width: 75, height: 30)
	.padding()
	.background(
		Color(cgColor: AppColor.Background.screen.cgColor)
	)
}
#endif
