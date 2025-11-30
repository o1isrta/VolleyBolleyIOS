import UIKit

protocol NavBarViewProtocol: AnyObject {
	var presenter: NavBarPresenterProtocol? { get set }

	func configure(with viewModel: NavBarViewModel)
	func updateNotifications(_ hasNewNotifications: Bool)
	func setViewController(_ viewController: UIViewController?)
}

final class CustomNavBarView: UIView {

	// MARK: - Public Properties

	var presenter: NavBarPresenterProtocol?

	// MARK: - Private Properties

	private weak var parentViewController: UIViewController?

	private enum Constants {
		static let avatarSize: CGFloat = 46
	}

    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            avatarImageView,
            nameLabel,
            notificationButtonView,
            levelView
        ])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 14
        view.setCustomSpacing(4, after: notificationButtonView)
        return view
    }()

	private let avatarImageView = AvatarImageView()
	private let levelView = LevelBadgeView()
	private let nameLabel = CustomTitle(text: "")
	private let notificationButtonView = NotificationButtonView()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupView()
		setupLayout()
		notificationButtonView.delegate = self
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		if superview != nil {
			notifyPresenterIfReady()
		}
	}

	// MARK: - Public Methods

	func configure(with viewModel: NavBarViewModel) {
		avatarImageView.configure(with: viewModel.avatarImage)
		nameLabel.text = viewModel.displayName.capitalized
		levelView.configure(with: viewModel.level)
	}
}

// MARK: - Private Methods

private extension CustomNavBarView {

	// MARK: - VIPER Integration

	func setupVIPERIfNeeded() {
		guard presenter == nil else { return }

		let navBarView = NavBarAssembly.createModule(with: parentViewController)
		self.presenter = navBarView.presenter
	}

	func notifyPresenterIfReady() {
		guard let presenter = presenter else {
			setupVIPERIfNeeded()
			return
		}
		presenter.viewIsReady()
	}

	func setupView() {
		addSubview(hStackView)

	}

    func setupLayout() {
        hStackView.pinToSuperviewEdges()

        NSLayoutConstraint.activate([
            hStackView.heightAnchor.constraint(equalTo: heightAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: hStackView.heightAnchor),
            levelView.widthAnchor.constraint(equalTo: hStackView.heightAnchor),
            notificationButtonView.heightAnchor.constraint(equalTo: hStackView.heightAnchor),
            notificationButtonView.widthAnchor.constraint(equalTo: hStackView.heightAnchor)
        ])
    }
}

// MARK: - NavBarViewProtocol

extension CustomNavBarView: NavBarViewProtocol {

	func updateNotifications(_ hasNewNotifications: Bool) {
		notificationButtonView.hasNewNotifications(hasNewNotifications)
	}

	func setViewController(_ viewController: UIViewController?) {
		self.parentViewController = viewController
	}
}

// MARK: - NotificationButtonDelegate

extension CustomNavBarView: NotificationButtonDelegate {

	func notificationButtonDidTap() {
		presenter?.notificationButtonTapped()
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let view = NavBarAssembly.createModule(with: nil)
		view.updateNotifications(true)
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()

	UIViewPreview {
		let view = NavBarAssembly.createModule(with: nil)
		return view
	}
	.frame(width: .infinity, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
