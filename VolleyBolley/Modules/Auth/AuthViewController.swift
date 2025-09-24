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
        return label
    }()

    private lazy var phoneAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "Continue with phone number"), for: .normal)
        button.titleLabel?.font = AppFont.Hero.bold(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = AppColor.Background.buttonYellowSelected
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()

    private lazy var googleAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("  " + String(localized: "Continue with Google"), for: .normal)
        button.titleLabel?.font = AppFont.Hero.bold(size: 18)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = AppColor.Background.primary
		button.setImage(UIImage.Icon.google, for: .normal)

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
        return view
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Image.auth)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    private func setupUI() {
        [backgroundImageView,
         descriptionLabel,
         bottomView].forEach {
            view.addSubviews($0)
        }

        bottomView.addSubview(buttonsStack)

        buttonsStack.addArrangedSubview(phoneAuthButton)
        buttonsStack.addArrangedSubview(googleAuthButton)

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
            bottomView.heightAnchor.constraint(equalToConstant: 170),

            buttonsStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            buttonsStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            buttonsStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24)
        ])
    }

    private func setupActions() {
        phoneAuthButton.addTarget(self, action: #selector(phoneTapped), for: .touchUpInside)
        googleAuthButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
    }

    @objc private func phoneTapped() {
        presenter?.phoneButtonTapped()
    }

    @objc private func googleTapped() {
        presenter?.googleButtonTapped()
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    AuthViewController()
}
#endif
