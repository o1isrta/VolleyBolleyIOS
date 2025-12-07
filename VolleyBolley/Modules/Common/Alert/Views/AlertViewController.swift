//
//  AlertViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import UIKit

final class AlertViewController: UIViewController {

    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.modal
        view.layer.cornerRadius = 32
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                messageLabel,
                bulletStackView,
                buttonStackView
            ]
        )
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()

    private lazy var titleLabel: CustomTitle = {
        let label = CustomTitle(isLarge: true)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private let messageLabel = CustomLabel(isBold: true)

    private lazy var bulletStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 7
        return stack
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    // MARK: - Public Methods

    func configure(with model: AlertModel) {
        titleLabel.isHidden = model.title == nil
        titleLabel.text = model.title

        messageLabel.text = model.message
        messageLabel.textAlignment = model.messageAlignment

        rebuildBullets(model.bullets)
        rebuildButtons(model.actions)
    }

    func dismissAlert() {
        dismiss(animated: false)
    }

    // MARK: - Private Methods

    private func rebuildBullets(_ bullets: [String]?) {
        bulletStackView.arrangedSubviews.forEach {
            bulletStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        guard let bullets, !bullets.isEmpty else {
            bulletStackView.isHidden = true
            return
        }

        bulletStackView.isHidden = false

        for text in bullets {
            let label = CustomLabel(isBold: true)
            label.textAlignment = .left
            label.text = "• \(text)"
            bulletStackView.addArrangedSubview(label)
        }
    }

    private func rebuildButtons(_ actions: [AlertActionModel]) {
        buttonStackView.arrangedSubviews.forEach {
            buttonStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        guard !actions.isEmpty else {
            buttonStackView.isHidden = true
            return
        }
        buttonStackView.isHidden = false

        if actions.count == 1 {
            buttonStackView.distribution = .fill
            let btn = makeButton(from: actions[0])
            btn.setContentHuggingPriority(.defaultLow, for: .horizontal)
            btn.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            buttonStackView.addArrangedSubview(btn)
            return
        }

        let hasMax = actions.contains { $0.maxWidthFraction != nil }
        if !hasMax {
            buttonStackView.distribution = .fillEqually
            for model in actions.prefix(2) {
                let btn = makeButton(from: model)
                btn.setContentHuggingPriority(.defaultLow, for: .horizontal)
                btn.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                buttonStackView.addArrangedSubview(btn)
            }
            return
        }

        buttonStackView.distribution = .fill
        buttonStackView.alignment = .fill

        var widthConstraints: [NSLayoutConstraint] = []

        for model in actions.prefix(2) {
            let btn = makeButton(from: model)
            btn.translatesAutoresizingMaskIntoConstraints = false

            if let maxFrac = model.maxWidthFraction, maxFrac > 0 {
                let maxC = btn.widthAnchor.constraint(
                    lessThanOrEqualTo: buttonStackView.widthAnchor,
                    multiplier: maxFrac
                )
                maxC.priority = .required
                widthConstraints.append(maxC)
                btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                btn.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            } else {
                btn.setContentHuggingPriority(.defaultLow, for: .horizontal)
                btn.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            }

            buttonStackView.addArrangedSubview(btn)
        }

        NSLayoutConstraint.activate(widthConstraints)
    }

    private func makeButton(from model: AlertActionModel) -> UIButton {
        let button = YellowButton()
        button.setTitle(model.title, for: .normal)
        button.isSelected = model.isPrimary
        button.addAction(UIAction { _ in model.handler?() }, for: .touchUpInside)
        return button
    }

    private func setupViews() {
        view.backgroundColor = AppEffect.BackgroundAlert.alert
        view.addSubviews(alertView)
        alertView.addSubviews(mainStackView)
    }

    private func setupLayout() {
        setupConstraintsAlertView()
        mainStackView.pinToSuperviewEdges(insets: .init(top: 20, left: 20, bottom: 20, right: 20))
    }

    // MARK: - Constraints

    private func setupConstraintsAlertView() {
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
