import UIKit

final class CustomNavBarView: UIView {

	private enum Constants {
		static let avatarSize: CGFloat = 46
		static let avatarLeading: CGFloat = 8
		static let avatarBottom: CGFloat = -8

		static let nameLabelLeading: CGFloat = 8

		static let notificationSize: CGFloat = 46
		static let notificationTrailing: CGFloat = -2
		static let notificationBottom: CGFloat = -8

		static let navBarCornerRadius: CGFloat = 32
		static let levelViewTrailing: CGFloat = -8
		static let levelViewBottom: CGFloat = -8
	}

	// MARK: - Private Properties

	private lazy var avatarImageView = AvatarImageView()
	private lazy var levelView = LevelBadgeView()
	private lazy var nameLabel = CustomTitle(text: "")
	private lazy var notificationButtonView = NotificationButtonView()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupView()
		setupLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(with viewModel: NavBarViewModel) {
		avatarImageView.configure(with: viewModel.avatarImage)
		nameLabel.text = viewModel.displayName.capitalized
		levelView.configure(with: viewModel.level)
	}

	func hasNewNotifications(_ hasNewNotifications: Bool) {
		notificationButtonView.hasNewNotifications(hasNewNotifications)
	}
}

// MARK: - Private Methods

private extension CustomNavBarView {

	func setupView() {
		backgroundColor = AppColor.Background.navBar
		layer.cornerRadius = Constants.navBarCornerRadius
		layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		layer.masksToBounds = true

		addSubviews(
			avatarImageView,
			nameLabel,
			notificationButtonView,
			levelView
		)
	}

	// MARK: - Layout Setup

	func setupLayout() {
		setupConstraintsAvatarImageView()
		setupConstraintsNameLabel()
		setupConstraintsNotificationButtonView()
		setupConstraintsLevelView()
	}

	// MARK: - Constraints

	func setupConstraintsNotificationButtonView() {
		NSLayoutConstraint.activate([
			notificationButtonView.trailingAnchor
				.constraint(
					equalTo: levelView.leadingAnchor,
					constant: Constants.notificationTrailing
				),
			notificationButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.notificationBottom),
			notificationButtonView.widthAnchor.constraint(equalToConstant: Constants.notificationSize),
			notificationButtonView.heightAnchor.constraint(equalToConstant: Constants.notificationSize)
		])
	}

	func setupConstraintsAvatarImageView() {
		NSLayoutConstraint.activate([
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.avatarLeading),
			avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.avatarBottom),
			avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
			avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize)
		])
	}

	func setupConstraintsNameLabel() {
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(
				equalTo: avatarImageView.trailingAnchor,
				constant: Constants.nameLabelLeading
			),
			nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
		])
	}

	func setupConstraintsLevelView() {
		NSLayoutConstraint.activate([
			levelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.levelViewTrailing),
			levelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.levelViewBottom)
		])
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let view = CustomNavBarView()
		view.hasNewNotifications(true)
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()

	UIViewPreview {
		let view = CustomNavBarView()
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
