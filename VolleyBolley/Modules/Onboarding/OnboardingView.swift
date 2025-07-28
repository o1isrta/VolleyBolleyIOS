//
//  OnboardingView.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresenterProtocol?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Welcome!")
        label.font = AppFont.ActayWide.bold(size: 36)
        label.textColor = AppColor.Text.primary
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "This app helps you find beach volleyball games and match with players at your skill level.")
        label.font = AppFont.Hero.regular(size: 20)
        label.textColor = AppColor.Text.primary
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: .vbLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "VOLLEYBOLLEY")
        label.font = AppFont.ActayWide.bold(size: 36)
        label.textColor = AppColor.Text.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var getStartedButton: UIButton = NextStepButton(title: String(localized: "GET STARTED"), isActive: true)

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .launch)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .launchScreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
    }

    private func setupUI() {
           view.addSubview(backgroundImageView)
           view.addSubview(titleLabel)
           view.addSubview(descriptionLabel)
           view.addSubview(logoImageView)
           view.addSubview(appNameLabel)
           view.addSubview(getStartedButton)

           NSLayoutConstraint.activate([
               backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
               backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

               titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
               titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),

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

    @objc private func getStartedTapped() {
        presenter?.getStartedButtonTapped()
    }
}

extension OnboardingViewController: OnboardingViewProtocol {
    
}
