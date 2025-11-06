//
//  PhoneVerifyViewController.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//

import UIKit

protocol PhoneVerifyViewProtocol: AnyObject {
    func enableVerifyButton(_ isEnabled: Bool)
    func showError(_ message: String)
    func hideError()
}

final class PhoneVerifyViewController: UIViewController, PhoneVerifyViewProtocol {

    var presenter: PhoneVerifyPresenterProtocol?

    private var errorLabelHeightConstraint: NSLayoutConstraint?
    private let phoneNumber: String?
    private var timer: Timer?
    private var secondsRemaining = 30

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.blur
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        return view
    }()

    private lazy var backButton: UtilityButton = {
        let button = UtilityButton(style: .small)
        button.setImage(.chevronBackward, for: .normal)
        button.tintColor = AppColor.Icon.primary
        return button
    }()

    private lazy var titleLabel = CustomTitle(text: String(localized: "Registration"), isLarge: true)

    private lazy var codeLabel = CustomLabel(text: String(localized: "Enter the 6-digit code"), isBold: true)

    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        let placeholderText = "XXXXXX"
        textField.placeholder = placeholderText
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColor.Border.primary.cgColor
        textField.backgroundColor = .systemBackground
        textField.textColor = AppColor.Text.placeHolder
        textField.addTarget(self, action: #selector(codeDidChange), for: .editingChanged)

        let attributed = NSAttributedString(
            string: placeholderText,
            attributes: [.kern: 7, .foregroundColor: AppColor.Text.placeHolder]
        )
        textField.attributedPlaceholder = attributed

        return textField
    }()

    private lazy var resendLabel = CustomLabel(text: "", isBold: true)

    private lazy var errorLabel: CustomLabel = {
        let errorLabel = CustomLabel(text: "", isBold: true)
        errorLabel.font = AppFont.Hero.light(size: 14)
        errorLabel.isHidden = true
        return errorLabel
    }()

    private lazy var getNewCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized: "Get new code"), for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 14)
        button.isHidden = true
        return button
    }()

    private lazy var verifyButton: YellowButton = {
        let button = YellowButton(title: String(localized: "VERIFY"))
        button.isEnabled = false
        return button
    }()

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getNewCodeButton.applyTextGradient(withUnderline: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        setupUI()
        setupActions()
        startResendTimer()
		hideKeyboardWhenTappedAround()
        presenter?.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    private func setupUI() {
		view.addSubviews(containerView)
		containerView.addSubviews(
			backButton,
			titleLabel,
			codeLabel,
			codeTextField,
			resendLabel,
			errorLabel,
			getNewCodeButton,
			verifyButton
		)

        errorLabelHeightConstraint = errorLabel.heightAnchor.constraint(equalToConstant: 17)
        errorLabelHeightConstraint?.isActive = true

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

            codeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            codeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            codeTextField.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 8),
            codeTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            codeTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            codeTextField.heightAnchor.constraint(equalToConstant: 51),

            errorLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 4),
            errorLabel.centerXAnchor.constraint(equalTo: codeTextField.centerXAnchor),

            resendLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 8),
            resendLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            getNewCodeButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 8),
            getNewCodeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            verifyButton.topAnchor.constraint(equalTo: resendLabel.bottomAnchor, constant: 18),
            verifyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            verifyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            verifyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        getNewCodeButton.addTarget(self, action: #selector(getNewCodeTapped), for: .touchUpInside)
        verifyButton.addTarget(self, action: #selector(verifyTapped), for: .touchUpInside)
    }

    private func startResendTimer() {
        resendLabel.isHidden = false
        getNewCodeButton.isHidden = true
        secondsRemaining = 30
        updateResendLabel()

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.secondsRemaining -= 1
            if self.secondsRemaining <= 0 {
                self.timer?.invalidate()
                self.timer = nil
                self.resendLabel.isHidden = true
                self.getNewCodeButton.isHidden = false
            } else {
                self.updateResendLabel()
            }
        }
    }

    private func updateResendLabel() {
           resendLabel.text = "Resend in 00:\(secondsRemaining < 10 ? "0\(secondsRemaining)" : "\(secondsRemaining)")"
       }

    @objc private func getNewCodeTapped() {
        startResendTimer()
        presenter?.didTapResendCode()
    }

    @objc private func codeDidChange() {
        guard let text = codeTextField.text else { return }

        let attributed = NSAttributedString(
            string: text,
            attributes: [.kern: 7, .foregroundColor: codeTextField.textColor ?? UIColor.label]
        )

        codeTextField.attributedText = attributed
        presenter?.codeDidChange(codeTextField.text ?? "")
    }

    @objc private func backTapped() {
        presenter?.didTapBack()
    }

    @objc private func verifyTapped() {
        presenter?.didTapVerify(with: codeTextField.text ?? "")
    }

    func enableVerifyButton(_ isEnabled: Bool) {
        verifyButton.isSelected = isEnabled
        verifyButton.isEnabled = isEnabled
    }

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        errorLabelHeightConstraint?.constant = 17
        codeTextField.layer.borderColor = AppColor.Border.error.cgColor
        codeTextField.textColor = AppColor.Border.error
    }

    func hideError() {
        errorLabel.isHidden = true
        errorLabelHeightConstraint?.constant = 0
        codeTextField.layer.borderColor = AppColor.Border.primary.cgColor
        codeTextField.textColor = AppColor.Text.placeHolder
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    PhoneVerifyViewController(phoneNumber: "123")
}
#endif
