//
//  AuthViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import UIKit

/// Экран авторизации через телефон, google, facebook
final class AuthViewController: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol?

    private lazy var descriptionLabel: UILabel = {
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var phoneAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "Continue with phone number"), for: .normal)
        button.titleLabel?.font = AppFont.Hero.bold(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = AppColor.Background.largeActionButtonDefault
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()

    private lazy var googleAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "  Continue with Google"), for: .normal)
        button.titleLabel?.font = AppFont.Hero.bold(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = .white

        if let googleIcon = UIImage(named: "google") {
            button.setImage(googleIcon, for: .normal)
        }

        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()

    private lazy var facebookAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "  Continue with Facebook"), for: .normal)
        button.titleLabel?.font = AppFont.Hero.bold(size: 18)
        button.setTitleColor(AppColor.Text.primary, for: .normal)
        button.backgroundColor = AppColor.Background.fbButton
        if let facebookIcon = UIImage(named: "facebook") {
            button.setImage(facebookIcon, for: .normal)
        }

        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.tabBar
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .auth)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(bottomView)

        bottomView.addSubview(buttonsStack)

        buttonsStack.addArrangedSubview(phoneAuthButton)
        buttonsStack.addArrangedSubview(googleAuthButton)
        buttonsStack.addArrangedSubview(facebookAuthButton)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),

            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 250),

            buttonsStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            buttonsStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            buttonsStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24)
        ])
    }

    private func setupActions() {
        phoneAuthButton.addTarget(self, action: #selector(phoneTapped), for: .touchUpInside)
        googleAuthButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        facebookAuthButton.addTarget(self, action: #selector(facebookTapped), for: .touchUpInside)
    }

    @objc private func phoneTapped() {
        presenter?.phoneButtonTapped()
    }

    @objc private func googleTapped() {
        presenter?.googleButtonTapped()
    }

    @objc private func facebookTapped() {
        presenter?.facebookButtonTapped()
    }

}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    AuthViewController()
}
#endif
