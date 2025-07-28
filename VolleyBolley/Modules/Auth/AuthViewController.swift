//
//  AuthViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

final class AuthViewController: UIViewController {
    var onLogin: (() -> Void)?

    // MARK: - Private Properties

    private let loginField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = AppColor.Background.screen
        loginField.placeholder = "Login"
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [loginField, passwordField, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }

    // MARK: - Actions

    @objc private func loginTapped() {
        onLogin?()
    }
}
