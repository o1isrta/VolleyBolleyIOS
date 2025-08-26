//
//  PhoneRegViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 16.08.2025.
//
import UIKit

final class PhoneAuthViewController: UIViewController {

    var presenter: PhoneAuthPresenterProtocol?

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.blur
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.left")
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let button = UIButton(configuration: config, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var titleLabel = CustomTitle(text: "Registration", isLarge: true)

    private lazy var phoneNumberLabel = CustomLabel(text: "Your phone number", isBold: true)

    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "+ With the country code",
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(phoneNumberDidChange), for: .editingChanged)
        textField.accessibilityIdentifier = "phoneTextField"
        return textField
    }()

    private lazy var nextButton: NextStepButton = {
        let button = NextStepButton(
            title: String(localized: "SEND CODE"),
            isActive: false,
            target: self,
            action: #selector(nextStepTapped)
        )
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        setupUI()
        setupActions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phoneTextField.becomeFirstResponder()
    }

    private func setupUI() {
        view.addSubview(containerView)
        [backButton, titleLabel, phoneNumberLabel, phoneTextField, nextButton]
            .forEach { containerView.addSubview($0) }

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22.5),
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

    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextStepTapped), for: .touchUpInside)
    }

    @objc private func phoneNumberDidChange() {
        let phoneNumber = phoneTextField.text ?? ""
        presenter?.phoneNumberDidChange(phoneNumber)
    }

    @objc private func backTapped() {
        presenter?.didTapBack()
    }

    @objc private func nextStepTapped() {
        let phoneNumber = phoneTextField.text ?? ""
        presenter?.didTapNextStep(with: phoneNumber)
    }
}

extension PhoneAuthViewController: PhoneAuthViewProtocol {
    func setNextButtonActive(_ isActive: Bool) {
        nextButton.setActive(isActive)
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
