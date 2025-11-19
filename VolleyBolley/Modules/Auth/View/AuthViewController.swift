//
//  AuthViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import Combine
import UIKit

enum AuthViewState: Equatable {
    case idle
    case loading
    case alertError(String)
    case success
}

@MainActor
final class AuthViewController: UIViewController {

    private let presenter: AuthPresenterProtocol
    private var cancellables: Set<AnyCancellable> = []

    private let loadingView = ProgressHub()

    private lazy var alertView: CustomAlertView = {
        let view = CustomAlertView()
        view.isHidden = true
        return view
    }()

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
            self?.presenter.didTapContinuePhone()
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
            self?.presenter.didTapContinueWithGoogle()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneAuthButton, googleAuthButton])
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

    // MARK: - Initializers

    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        cancellables.removeAll()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindPresenter()
    }

    // MARK: - Private Methods

    private func bindPresenter() {
        presenter.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleStateChange(state)
            }
            .store(in: &cancellables)
    }

    private func handleStateChange(_ state: AuthViewState) {
        switch state {
        case .idle:
            loadingView.hide()
        case .loading:
            loadingView.show(in: view)
        case .alertError(let message):
            loadingView.hide()
            showAlert(message: message)
        case .success:
            loadingView.hide()
        }
    }

    private func showAlert(message: String) {
        guard alertView.isHidden else { return }

        let button = ButtonDataModel(
            title: String(localized: "customAlertView.button.ok"),
            action: { [weak self] in
                self?.hideAlert()
            }
        )

        let alertModel = CustomAlertModel(
            title: String(localized: "errorTitleError"),
            message: message,
            primaryButton: button
        )

        alertView.configure(with: alertModel)
        alertView.alpha = 0
        alertView.isHidden = false
        view.bringSubviewToFront(alertView)

        UIView.animate(withDuration: 0.25) {
            self.alertView.alpha = 1
        }
    }

    private func hideAlert() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }, completion: { _ in
            self.alertView.isHidden = true
        })
    }

    private func setupUI() {
        view.addSubviews(backgroundImageView, descriptionLabel, bottomView, alertView)

        bottomView.addSubview(buttonsStack)

        backgroundImageView.pinToSuperviewEdges()
        alertView.pinToSuperviewEdges()

        NSLayoutConstraint.activate([
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
}
