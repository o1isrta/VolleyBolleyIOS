//
//  PhoneAuthViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 16.08.2025.
//
import UIKit

final class PhoneAuthViewController: UIViewController {

	var presenter: PhoneAuthPresenterProtocol?

	private lazy var containerView = GlassmorphismView()

	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addAction(UIAction { [weak self] _ in
			self?.backTapped()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var titleLabel = CustomTitle(text: String(localized: "Registration"), isLarge: true)

	private lazy var phoneNumberLabel = CustomLabel(text: String(localized: "Your phone number"), isBold: true)

	private lazy var phoneTextField: UITextField = {
		let textField = UITextField()
		textField.attributedPlaceholder = NSAttributedString(
			string: String(localized: "+ With the country code"),
			attributes: [.foregroundColor: AppColor.Text.placeHolder]
		)
		textField.keyboardType = .phonePad
		textField.borderStyle = .none
		textField.layer.cornerRadius = 16
		textField.layer.borderWidth = 1
		textField.layer.borderColor = AppColor.Border.primary.cgColor
		textField.backgroundColor = .systemBackground
		textField.textColor = AppColor.Text.placeHolder
		textField.setLeftPaddingPoints(16)
		textField.addAction(UIAction { [weak self] _ in
			self?.phoneNumberDidChange()
		}, for: .editingChanged)
		textField.accessibilityIdentifier = "phoneTextField"
		return textField
	}()

	private lazy var nextButton: YellowButton = {
		let button = YellowButton(title: String(localized: "SEND CODE"))
		button.isEnabled = false
		button.addAction(UIAction { [weak self] _ in
			self?.nextStepTapped()
		}, for: .touchUpInside)
		return button
	}()

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.hideNavigationBar()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = AppColor.Background.screen
		setupUI()
		hideKeyboardWhenTappedAround()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		phoneTextField.becomeFirstResponder()
	}

	private func setupUI() {
		view.addSubviews(containerView)
		containerView.addSubviews(
			backButton,
			titleLabel,
			phoneNumberLabel,
			phoneTextField,
			nextButton
		)

		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

			backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
			backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
			backButton.widthAnchor.constraint(equalToConstant: 18),
			backButton.heightAnchor.constraint(equalToConstant: 24),

			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
			titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

			phoneNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
			phoneNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

			phoneTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
			phoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
			phoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
			phoneTextField.heightAnchor.constraint(equalToConstant: 51),

			nextButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
			nextButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
			nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
			nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
		])
	}

	private func phoneNumberDidChange() {
		let phoneNumber = phoneTextField.text ?? ""
		presenter?.phoneNumberDidChange(phoneNumber)
	}

	private func backTapped() {
		presenter?.didTapBack()
	}

	private func nextStepTapped() {
		let phoneNumber = phoneTextField.text ?? ""
		presenter?.didTapNextStep(with: phoneNumber)
	}
}

extension PhoneAuthViewController: PhoneAuthViewProtocol {

	func setNextButtonActive(_ isActive: Bool) {
		nextButton.isSelected = isActive
		nextButton.isEnabled = isActive
	}

	func updateNextButtonTitle(_ title: String) {
		UIView.transition(with: nextButton, duration: 0.3, options: [.transitionCrossDissolve, .allowUserInteraction]) {
			self.nextButton.setTitle(title, for: .normal)
		}
	}

	func autoFillCountryCode(_ code: String) {
		guard let text = phoneTextField.text, text.isEmpty || text.first != "+" else { return }
		phoneTextField.text = code
	}

	func updatePhoneNumberText(_ text: String) {
		phoneTextField.text = text
	}
}

@available(iOS 17.0, *)
#Preview {
	PhoneAuthViewController()
}
