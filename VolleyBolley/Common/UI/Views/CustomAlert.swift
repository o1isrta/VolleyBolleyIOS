//
//  CustomAlert.swift
//  VolleyBolley
//
//  Created by Вадим on 15.07.2025.
//

import UIKit

struct CustomAlertModel {
    let title: String?
    let doneAction: (() -> Void)?
    let cancelAction: (() -> Void)?
    let alertType: AlertType
}

enum AlertType {
    case twoButtons
    case oneButton
}

final class CustomAlertView: UIView {

    // MARK: - Private Properties

    private var doneActionButton: (() -> Void)?
    private var cancelActionButton: (() -> Void)?

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppEffect.BackgroundAlert.alert
        return view
    }()

    private lazy var customViewAlert: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.modal
        view.layer.cornerRadius = 32
        return view
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.ActayWide.bold(size: 16)
        label.textColor = AppColor.Text.primary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(AppColor.Background.actionButtonDefault, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = AppFont.ActayWide.bold(size: 16)
        button.layer.borderColor = AppColor.Background.actionButtonDefault.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = AppColor.Background.actionButtonDefault
        button.titleLabel?.font = AppFont.ActayWide.bold(size: 16)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [doneButton, cancelButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(with model: CustomAlertModel) {
        messageLabel.text = model.title

        switch model.alertType {
        case .twoButtons:
            doneButton.isHidden = false
            cancelButton.isHidden = false
            doneActionButton = model.doneAction
            cancelActionButton = model.cancelAction
            styleYesButtonAsSecondary()

        case .oneButton:
            doneButton.isHidden = false
            cancelButton.isHidden = true
            doneActionButton = model.doneAction
            styleYesButtonAsPrimary()
        }
    }

    // MARK: - Private Method

    private func styleYesButtonAsPrimary() {
        doneButton.setTitleColor(AppColor.Text.inverted, for: .normal)
        doneButton.backgroundColor = AppColor.Background.actionButtonDefault
        doneButton.layer.borderWidth = 0
    }

    private func styleYesButtonAsSecondary() {
        doneButton.setTitleColor(AppColor.Background.actionButtonDefault, for: .normal)
        doneButton.backgroundColor = .clear
        doneButton.layer.borderWidth = 1.0
        doneButton.layer.borderColor = AppColor.Background.actionButtonDefault.cgColor
    }

    // MARK: - Actions

    @objc private func yesButtonTapped() {
        doneActionButton?()
    }

    @objc private func noButtonTapped() {
        cancelActionButton?()
    }
}

// MARK: - Constants

private extension CustomAlertView {
    
    func setupUI() {
        addSubviews(
            backgroundView,
            customViewAlert
        )

        customViewAlert.addSubviews(
            messageLabel,
            buttonStack
        )
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            customViewAlert.centerXAnchor.constraint(equalTo: centerXAnchor),
            customViewAlert.centerYAnchor.constraint(equalTo: centerYAnchor),
            customViewAlert.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            customViewAlert.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            messageLabel.topAnchor.constraint(equalTo: customViewAlert.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: customViewAlert.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: customViewAlert.trailingAnchor, constant: -20),
            messageLabel.heightAnchor.constraint(equalToConstant: 38),

            buttonStack.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 12),
            buttonStack.leadingAnchor.constraint(equalTo: customViewAlert.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: customViewAlert.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: customViewAlert.bottomAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
