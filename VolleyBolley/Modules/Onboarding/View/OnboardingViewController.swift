//
//  OnboardingViewController.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject where Self: UIViewController {}

final class OnboardingViewController: UIViewController, OnboardingViewProtocol {

    // MARK: - Private Properties

    private let presenter: OnboardingPresenterProtocol

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = String(localized: "onboarding.title")
		label.font = AppFont.ActayWide.bold(size: 36)
		label.textColor = AppColor.Text.primary
		label.textAlignment = .left
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.5
		return label
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.text = String(localized: "onboarding.description")
		label.font = AppFont.Hero.regular(size: 20)
		label.textColor = AppColor.Text.primary
		label.numberOfLines = 0
		label.textAlignment = .left
		return label
	}()

	private lazy var logoImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage.Image.vbLogo)
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var appNameLabel: UILabel = {
		let label = UILabel()
		label.text = "VOLLEYBOLLEY"
		label.font = AppFont.ActayWide.bold(size: 36)
		label.textColor = AppColor.Text.primary
		return label
	}()

    private lazy var getStartedButton: YellowButton = {
        let view = YellowButton()
        view.isSelected = true
        view.setTitle(String(localized: "GET STARTED"), for: .normal)
        view.addAction(UIAction { [weak self] _ in
            self?.presenter.didTapGetStarted()
        }, for: .touchUpInside)
        return view
    }()

	private lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage.Image.launch)
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .launchScreen
		return imageView
	}()

    // MARK: - Initializers

    init(presenter: OnboardingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

// MARK: - Private Methods

private extension OnboardingViewController {

	func setupUI() {
		view.addSubviews(
			backgroundImageView,
			titleLabel,
			descriptionLabel,
			logoImageView,
			appNameLabel,
			getStartedButton
		)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
			titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
			titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),

			descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17),
			descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
			descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),

			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

			logoImageView.widthAnchor.constraint(equalToConstant: 200),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),

			appNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
			appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -29),
			getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
		])
	}
}
