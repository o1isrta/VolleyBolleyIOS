//
//  GamePrivacyView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.01.2026.
//

import UIKit

final class GamePrivacyView: UIView {

	// MARK: - Public Properties

	override var intrinsicContentSize: CGSize {
		return CGSize(
			width: UIView.noIntrinsicMetric,
			height: Constants.intrinsicContentHeight
		)
	}

	// MARK: - Private Properties

	private	let privacyChanged: ((Bool) -> Void)

	private	enum Constants {
		static let intrinsicContentHeight: CGFloat = 114

		static let stackSpacing: CGFloat = 10
		static let stackLayoutMargins: UIEdgeInsets =  .init(
			top: 12,
			left: 0,
			bottom: 0,
			right: 0
		)
	}

	private let privacyTitle = CustomTitle(
		text: String(localized: "gamePrivacy.title"),
		isLarge: true
	)

	private let privacyDescription = CustomLabel(
		text: String(localized: "gamePrivacy.description")
	)

	private lazy var privacyPublicButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(
			String(localized: "gamePrivacy.publicButton"),
			for: .normal
		)
		button.addAction(UIAction { [weak self] _ in
			self?.updatePrivacyState(isPublic: true)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var privacyPrivateButton: GreenButton = {
		let button = GreenButton(imagePlacement: .trailing)
		button.setTitle(
			String(localized: "gamePrivacy.privateButton"),
			for: .normal
		)
		button.setImage(.arrowForward, for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.updatePrivacyState(isPublic: false)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var privacyButtonsStackView: UIStackView = {
		let view = UIView()
		view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		let stack = UIStackView(arrangedSubviews: [
			privacyPublicButton,
			privacyPrivateButton,
			view
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .leading
		stack.spacing = Constants.stackSpacing
		stack.layoutMargins = Constants.stackLayoutMargins
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private lazy var privacyStackView: UIStackView = {
		privacyTitle.setContentCompressionResistancePriority(.required, for: .vertical)
		privacyTitle.setContentHuggingPriority(.required, for: .vertical)
		privacyDescription.setContentCompressionResistancePriority(.required, for: .vertical)
		privacyDescription.setContentHuggingPriority(.required, for: .vertical)
		let stack = UIStackView(arrangedSubviews: [
			privacyTitle,
			privacyDescription,
			privacyButtonsStackView
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .fill
		return stack
	}()

	// MARK: - Initializers

	init(privacyChanged: @escaping ((Bool) -> Void)) {
		self.privacyChanged = privacyChanged
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }
}

// MARK: - Private Methods

private extension GamePrivacyView {

	func setupUI() {
		addSubviews(privacyStackView)
		privacyStackView.pinToSuperviewEdges()
	}

	func updatePrivacyState(isPublic: Bool) {
		privacyPublicButton.isSelected = isPublic
		privacyPrivateButton.isSelected = !isPublic
		privacyChanged(isPublic)
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI
@available(iOS 17.0, *)
#Preview {
	let height: CGFloat = 114

	VStack {
		UIViewPreview {
			GamePrivacyView { value in
				print("Game is public:", value)
			}
		}
		.frame(height: height)
	}
	.padding()
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
