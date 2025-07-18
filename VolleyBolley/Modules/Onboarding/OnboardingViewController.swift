//
//  OnboardingViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

final class OnboardingViewController: UIViewController {
    var onContinue: (() -> Void)?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.Background.screen

        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Actions
    @objc private func continueTapped() {
        onContinue?()
    }
}
