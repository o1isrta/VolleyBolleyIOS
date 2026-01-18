//
//  LevelInfoViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

final class LevelInfoViewController: UIViewController {

	// MARK: - Private Properties

	private struct LevelInfo {
		let title: String
		let description: String
	}

	private let levels: [LevelInfo] = [
		.init(
			title: String(localized: "common.light").capitalized(with: .current) + ":",
			description: String(localized: "New to the game")
		),
		.init(
			title: String(localized: "common.medium").capitalized(with: .current) + ":",
			description: String(localized: "Know rules, still learning")
		),
		.init(
			title: String(localized: "common.hard").capitalized(with: .current) + ":",
			description: String(localized: "Skilled, play often, tournaments experience")
		),
		.init(
			title: String(localized: "common.pro").capitalized(with: .current) + ":",
			description: String(localized: "Elite level, official championships experience")
		)
	]

	private enum Constants {
		static let padding: CGFloat = 8
		static let paddingDouble: CGFloat = 16
		static let paddingLarge: CGFloat = 20

		static let backButtonWidth: CGFloat = 18
		static let backButtonHeight: CGFloat = 24

		static let fontSize: CGFloat = 16

		static let titleWidth: CGFloat = 80
		static let descriptionNumberOfLines: Int = 0
		static let descriptionStackSpacing: CGFloat = 12
	}

	private let contentView: GlassmorphismView = {
		let container = GlassmorphismView()
		container.backgroundColor = AppColor.Background.screen
		return container
	}()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
			self?.dismiss(animated: true)
		}, for: .touchUpInside)
		return button
	}()

	private let titleLabel = CustomTitle(text: String(localized: "About levels"), isLarge: true)

	private lazy var levelsStack = makeLevelRow()

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		animatePopupAppearance()
		view.backgroundColor = AppEffect.Background.popup
	}
}

// MARK: - Private Methods

private extension LevelInfoViewController {

	func setupUI() {
		view.addSubviews(contentView)
		contentView.addSubviews(
			backButton,
			titleLabel,
			levelsStack
		)

		NSLayoutConstraint.activate([
			contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			contentView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Constants.padding
			),
			contentView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Constants.padding
			),

			backButton.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Constants.paddingLarge
			),
			backButton.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.paddingLarge
			),
			backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonWidth),
			backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonHeight),

			titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

			levelsStack.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.paddingDouble
			),
			levelsStack.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.paddingLarge
			),
			levelsStack.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.paddingLarge
			),
			levelsStack.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Constants.paddingLarge
			)
		])
	}

	func makeLevelRow() -> UIStackView {
		let levelsStack = UIStackView()
		levelsStack.axis = .vertical
		levelsStack.alignment = .fill
		levelsStack.spacing = Constants.paddingLarge

		for level in levels {
			let titleLabel: GradientLabel = {
				let label = GradientLabel()
				label.text = level.title
				label.font = AppFont.Hero.bold(size: Constants.fontSize)
				label.textColor = AppColor.Text.primary
				return label
			}()
			titleLabel.widthAnchor.constraint(equalToConstant: Constants.titleWidth).isActive = true

			let descriptionLabel = UILabel()
			descriptionLabel.text = level.description
			descriptionLabel.font = AppFont.Hero.regular(size: Constants.fontSize)
			descriptionLabel.textColor = AppColor.Text.primary
			descriptionLabel.numberOfLines = Constants.descriptionNumberOfLines

			let rowStack = UIStackView(arrangedSubviews: [
				titleLabel,
				descriptionLabel
			])
			rowStack.axis = .horizontal
			rowStack.spacing = Constants.descriptionStackSpacing
			rowStack.alignment = .top

			descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
			titleLabel.setContentHuggingPriority(.required, for: .horizontal)

			descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
			descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

			levelsStack.addArrangedSubview(rowStack)
		}

		return levelsStack
	}

	func animatePopupAppearance() {
		contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
		contentView.alpha = 0

		UIView.animate(withDuration: 0.25,
					   delay: 0,
					   usingSpringWithDamping: 0.8,
					   initialSpringVelocity: 0.6,
					   options: .curveEaseOut,
					   animations: {
			self.contentView.transform = .identity
			self.contentView.alpha = 1
		}, completion: nil)
	}
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	LevelInfoViewController()
}
#endif
