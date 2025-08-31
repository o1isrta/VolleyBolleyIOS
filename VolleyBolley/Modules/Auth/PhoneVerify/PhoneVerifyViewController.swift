//
//  PhoneVerifyViewController.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//
import UIKit

final class PhoneVerifyViewController: UIViewController, PhoneVerifyViewProtocol {
    var presenter: PhoneVerifyPresenterProtocol?

    private let phoneNumber: String?
    private var timer: Timer?
    private var secondsRemaining = 30

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.blur
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var titleLabel = CustomTitle(text: "Registration", isLarge: true)

    private lazy var codeLabel = CustomLabel(text: "Enter the 6-digit code", isBold: true)

    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "XXXXXX"
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.textAlignment = .center

        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColor.Border.primary.cgColor
        textField.backgroundColor = .systemBackground
        textField.textColor = AppColor.Text.placeHolder

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(сodeDidChange), for: .editingChanged)
        return textField
    }()

    private let resendLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let getNewCodeButton: GradientTextButton = {
        let button = GradientTextButton(type: .system)
        button.setTitle("Get new code", for: .normal)
        button.titleLabel?.font = AppFont.Hero.regular(size: 14)
        
        button.textGradientColors = [
            UIColor.red.cgColor,
            UIColor.black.cgColor
        ]
        
        button.textGradientStartPoint = CGPoint(x: 0.5, y: 0)
        button.textGradientEndPoint = CGPoint(x: 0.5, y: 1)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private lazy var verifyButton: NextStepButton = {
            let button = NextStepButton(
                title: "VERIFY",
                isActive: false,
                target: self,
                action: #selector(verifyTapped)
            )
            return button
        }()

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.Background.screen
        setupUI()
        setupActions()
        startResendTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Container bounds after layout: \(containerView.bounds)")
    }


    private func setupUI() {
        view.addSubview(containerView)
        [backButton, titleLabel, codeLabel, codeTextField, resendLabel, getNewCodeButton, verifyButton]
            .forEach { containerView.addSubview($0) }

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),

            backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22.5),
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

            resendLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 8),
            resendLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            getNewCodeButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 8),
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
    }

    private func startResendTimer() {
        resendLabel.isHidden = false
        getNewCodeButton.isHidden = true
        secondsRemaining = 30
        resendLabel.text = "Resend in 00:\(secondsRemaining < 10 ? "0\(secondsRemaining)" : "\(secondsRemaining)")"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.secondsRemaining -= 1
            if self.secondsRemaining > 0 {
                self.resendLabel.text = "Resend in 00:\(self.secondsRemaining < 10 ? "0\(self.secondsRemaining)" : "\(self.secondsRemaining)")"
            } else {
                self.timer?.invalidate()
                self.timer = nil
                self.resendLabel.isHidden = true
                self.getNewCodeButton.isHidden = false
            }
        }
    }
    
    @objc private func getNewCodeTapped() {
        startResendTimer()
        presenter?.didTapResendCode()
    }

    @objc private func сodeDidChange() {
        presenter?.codeDidChange(codeTextField.text ?? "")
    }

    @objc private func backTapped() {
        presenter?.didTapBack()
    }

    @objc private func verifyTapped() {
        presenter?.didTapVerify(with: codeTextField.text ?? "")
    }

    func enableVerifyButton(_ isEnabled: Bool) {
        verifyButton.setActive(isEnabled)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    PhoneVerifyViewController(phoneNumber: "")
}
#endif
