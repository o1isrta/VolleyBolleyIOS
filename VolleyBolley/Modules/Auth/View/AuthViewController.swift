//
//  AuthViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import UIKit

protocol AuthViewControllerProtocol: AnyObject {
	func isLoadingIndicatorVisible(_ isLoading: Bool)
	func showAlert(with message: String)
}

final class AuthViewController: UIViewController {

	// MARK: - Private Properties

	private let presenter: AuthPresenterProtocol

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		let text = String(localized: "Sign up\nwith\na social\nmedia")
		let attributedString = NSMutableAttributedString(string: text)

		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 18
		paragraphStyle.lineHeightMultiple = 1.1
		paragraphStyle.alignment = .left

		attributedString.addAttributes([
			.font: AppFont.ActayWide.bold(size: 36),
			.foregroundColor: AppColor.Text.primary,
			.paragraphStyle: paragraphStyle
		], range: NSRange(location: 0, length: text.count))

		label.attributedText = attributedString
		label.numberOfLines = 4
		return label
	}()

	private lazy var phoneAuthButton: UIButton = {
		let button = UIButton()
		var config = UIButton.Configuration.filled()
		var attributes = AttributeContainer()
		attributes.font = AppFont.Hero.bold(size: 18)
		attributes.foregroundColor = AppColor.Text.inverted
		config.attributedTitle = AttributedString(
			String(localized: "Continue with phone number"),
			attributes: attributes
		)
		config.baseBackgroundColor = AppColor.Background.buttonYellowSelected
		config.contentInsets = NSDirectionalEdgeInsets(top: 17, leading: 6, bottom: 17, trailing: 6)
		button.configuration = config
		button.layer.cornerRadius = 16
		button.clipsToBounds = true
		button.addAction(UIAction { [weak self] _ in
			self?.presenter.phoneButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var googleAuthButton: UIButton = {
		let button = UIButton()
		var config = UIButton.Configuration.filled()
		var attributes = AttributeContainer()
		attributes.font = AppFont.Hero.bold(size: 18)
		attributes.foregroundColor = AppColor.Text.inverted
		config.attributedTitle = AttributedString(
			String(localized: "Continue with Google"),
			attributes: attributes
		)
		config.image = UIImage.Icon.google
		config.imagePlacement = .leading
		config.imagePadding = 10
		config.baseBackgroundColor = AppColor.Background.primary
		config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 6, bottom: 16, trailing: 6)
		button.configuration = config
		button.layer.cornerRadius = 16
		button.clipsToBounds = true
		button.addAction(UIAction { [weak self] _ in
			self?.presenter.googleButtonTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var buttonsStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [phoneAuthButton, googleAuthButton])
		stack.axis = .vertical
		stack.spacing = 8
		return stack
	}()

	private let bottomView: UIView = {
		let view = UIView()
		view.backgroundColor = AppColor.Background.tabBar
		view.layer.cornerRadius = 32
		view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		view.clipsToBounds = true
		return view
	}()

	private let backgroundImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage.Image.auth)
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	private lazy var loadingIndicator = ProgressHub.shared

	private lazy var customAlertView: CustomAlertView = CustomAlertView()

	// MARK: - Initializers

	init(presenter: AuthPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		view.bringSubviewToFront(customAlertView)
		view.bringSubviewToFront(loadingIndicator)
	}
}

// MARK: - AuthViewControllerProtocol

extension AuthViewController: AuthViewControllerProtocol {

	func isLoadingIndicatorVisible(_ isLoading: Bool) {
		DispatchQueue.main.async {
			isLoading
				? self.loadingIndicator.show(in: self.view, withBlur: true, ballSize: .big)
				: self.loadingIndicator.hide()
			self.view.isUserInteractionEnabled = !isLoading
		}
	}

	func showAlert(with message: String) {
		customAlertView.isHidden = false
		let model = CustomAlertModel(
			message: message,
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.ok"),
				action: { self.customAlertView.isHidden = true }
			)
		)
		customAlertView.configure(with: model)
	}
}

// MARK: - Private Methods

private extension AuthViewController {

	func setupUI() {
		view.addSubviews(
			backgroundImageView,
			descriptionLabel,
			bottomView,
			customAlertView
		)
		bottomView.addSubviews(buttonsStack)

		backgroundImageView.pinToSuperviewEdges()
		customAlertView.pinToSuperviewEdges()

		NSLayoutConstraint.activate([
			descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),

			bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			bottomView.heightAnchor.constraint(equalTo: buttonsStack.heightAnchor, constant: 61),

			buttonsStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
			buttonsStack.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -41),
			buttonsStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
			buttonsStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20)
		])
	}
}

#if DEBUG
// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	class MockAuthPresenter: AuthPresenterProtocol {
		func phoneButtonTapped() { print("Phone button tapped") }
		func googleButtonTapped() { print("Google button tapped") }
	}
	let mockPresenter = MockAuthPresenter()
	let authVC = AuthViewController(presenter: mockPresenter)
	return authVC
}
#endif
