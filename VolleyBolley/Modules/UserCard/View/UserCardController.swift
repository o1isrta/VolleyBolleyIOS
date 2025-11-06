//
//  UserCardController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 06.11.2025.
//

import UIKit

final class UserCardController: BaseViewController {

	// MARK: - Public Properties

//	var presenter: UserCardControllerPresenterProtocol?

	// MARK: - Private Properties

	private enum LayoutConstants {
		static let littleIndent: CGFloat = 4
		static let mainIndent: CGFloat = 8
		static let mediumIndent: CGFloat = 16
		static let mainSpacing: CGFloat = 20
		static let backButtonTopInset: CGFloat = 14
		static let favoriteButtonTopInset: CGFloat = 12

		static let profilePhotoSize: CGFloat = 100

		static let glassmorphismViewHeight: CGFloat = 454 // TODO: -
		static let favoriteButtonHeight: CGFloat = 44
	}

	private let loadingIndicator = ProgressHub.shared

	private lazy var glassmorphismView = GlassmorphismView()

	private lazy var screenTitle = CustomTitle(
		text: "",
		isLarge: true
	)

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
//			self?.presenter?.backButtonTapped()// TODO: -
		}, for: .touchUpInside)
		return button
	}()

	private lazy var profilePhotoView = AvatarImageView()

	private lazy var levelLabel: GradientLabel = {
		let label = GradientLabel()
		label.font = AppFont.Hero.bold(size: 16)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 0
		return label
	}()

	private lazy var tableCaptionLabel: CustomLabel = CustomLabel(
		text: String(localized: "userCard.tableCaption"),
		isBold: true
	)

	private lazy var favoriteButton: YellowButton = {
		let button = YellowButton(
			title: String(localized: "button.favorite"),
			isSelected: true
		)
		button.isHidden = false
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.isFavoriteHidden(true)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var unfavoriteButton: YellowButton = {
		let button = YellowButton(
			title: String(localized: "button.unfavorite"),
			isSelected: false
		)
		button.isHidden = true
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.isFavoriteHidden(false)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var mainStack: UIStackView = {
		profilePhotoView.setContentHuggingPriority(.required, for: .horizontal)
		profilePhotoView.setContentHuggingPriority(.required, for: .vertical)
		profilePhotoView.setContentCompressionResistancePriority(.required, for: .horizontal)
		profilePhotoView.setContentCompressionResistancePriority(.required, for: .vertical)
		let stack = UIStackView(arrangedSubviews: [
			profilePhotoView,
			levelLabel,
			tableCaptionLabel,
			favoriteButton,
			unfavoriteButton
		])
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = LayoutConstants.littleIndent
		return stack
	}()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		// TODO: -
		configure()
	}

	func configure() {
		// TODO: -
		screenTitle.text = "Polina Vasilieva"
		profilePhotoView.configure(with: .imgPerson)
		levelLabel.text = "PRO"
	}
}

// MARK: - Private Methods

private extension UserCardController {

	func isFavoriteHidden(_ favorite: Bool) {
		favoriteButton.isHidden = favorite
		unfavoriteButton.isHidden = !favorite
//		presenter?.setAsFavorite(favorite)// TODO: -
	}

	func setupView() {
		setupViews()
		setupConstraints()
		setupLoadingIndicator()
	}

	func setupViews() {
		view.addSubviews(glassmorphismView)
		glassmorphismView.addSubviews(
			backButton,
			screenTitle,
			mainStack
		)
	}

	func setupLoadingIndicator() {
		view.addSubviews(loadingIndicator)
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: navBar.bottomAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: LayoutConstants.mainIndent),
			glassmorphismView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -LayoutConstants.mainIndent),
			glassmorphismView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.glassmorphismViewHeight),

			backButton.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: LayoutConstants.backButtonTopInset),
			backButton.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing / 2),

			screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			screenTitle.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: LayoutConstants.mainSpacing),
			screenTitle.leadingAnchor.constraint(
				lessThanOrEqualTo: backButton.trailingAnchor,
				constant: LayoutConstants.littleIndent),
			screenTitle.trailingAnchor.constraint(
				lessThanOrEqualTo: glassmorphismView.trailingAnchor,
				constant: LayoutConstants.mainSpacing),

			profilePhotoView.widthAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),
			profilePhotoView.heightAnchor.constraint(
				equalToConstant: LayoutConstants.profilePhotoSize),

			tableCaptionLabel.topAnchor.constraint(
				equalTo: levelLabel.bottomAnchor,
				constant: LayoutConstants.mainIndent),
			tableCaptionLabel.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
			tableCaptionLabel.trailingAnchor.constraint(
				lessThanOrEqualTo: glassmorphismView.trailingAnchor,
				constant: LayoutConstants.mainSpacing),

			mainStack.topAnchor.constraint(
				equalTo: screenTitle.bottomAnchor,
				constant: LayoutConstants.mediumIndent),
			mainStack.leadingAnchor.constraint(
				equalTo: glassmorphismView.leadingAnchor,
				constant: LayoutConstants.mainSpacing),
			mainStack.trailingAnchor.constraint(
				equalTo: glassmorphismView.trailingAnchor, constant: -LayoutConstants.mainSpacing),

			favoriteButton.topAnchor.constraint(
				equalTo: mainStack.bottomAnchor,
				constant: LayoutConstants.favoriteButtonTopInset),
			favoriteButton.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			favoriteButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
			favoriteButton.heightAnchor.constraint(equalToConstant: LayoutConstants.favoriteButtonHeight),

			unfavoriteButton.topAnchor.constraint(
				equalTo: mainStack.bottomAnchor,
				constant: LayoutConstants.favoriteButtonTopInset),
			unfavoriteButton.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
			unfavoriteButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
			unfavoriteButton.heightAnchor.constraint(equalToConstant: LayoutConstants.favoriteButtonHeight)
		])
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	let view = UserCardController()
	return view
}

#endif
