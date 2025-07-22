//
//  PhoneVerificationView.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 20.07.2025.
//
import UIKit

final class PhoneVerifyView: UIViewController, PhoneVerifyViewProtocol {
    var presenter: PhoneVerifyPresenterProtocol?
    private let phoneNumber: String?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.blur
        view.layer.cornerRadius = 32
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
        textField.textColor = AppColor.Text.placeholder
        
        textField.setLeftPaddingPoints(16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(verifCodeDidChange), for: .editingChanged)
        return textField
    }()
    
    private let verifyButton = NextStepButton(title: "VERIFY", initialState: .inactive)
    
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
        
        verifyButton.setTitle("VERIFY", for: .normal)
        verifyButton.setState(.inactive)
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(codeLabel)
        containerView.addSubview(codeTextField)
        containerView.addSubview(verifyButton)
        
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
            
            codeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            codeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            codeTextField.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 8),
            codeTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            codeTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            codeTextField.heightAnchor.constraint(equalToConstant: 51),
            
            verifyButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 20),
            verifyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            verifyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            verifyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        verifyButton.addTarget(self, action: #selector(verifTapped), for: .touchUpInside)
    }
    
    @objc private func verifCodeDidChange() {
        presenter?.codeDidChange(codeTextField.text ?? "")
    }
    
    @objc private func backTapped() {
        presenter?.didTapBack()
    }
    
    @objc private func verifTapped() {
        presenter?.didTapVerify(with: codeTextField.text ?? "")
    }
    
    func enableVerifyButton(_ isEnabled: Bool) {
        verifyButton.setState(isEnabled ? .active : .inactive)
    }
}
