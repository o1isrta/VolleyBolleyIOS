//
//  CustomAlert.swift
//  VolleyBolley
//
//  Created by Вадим on 15.07.2025.
//

import UIKit

struct CustomAlertModel {
    let title: String?
    let yesAction: (() -> Void)?
    let noAction: (() -> Void)?
    let alertType: AlertType
}

enum AlertType {
    case twoButtons
    case oneButton
}

final class CustomAlertView: UIView {

    // MARK: - Private Properties

    private var yesButtonAction: (() -> Void)?
    private var noButtonAction: (() -> Void)?

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppEffect.BackgroundAlert.alert
        return view
    }()

    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.modal
        view.layer.cornerRadius = 32
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.ActayWide.bold(size: 16)
        label.textColor = AppColor.Text.primary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 38).isActive = true
        return label
    }()

    private lazy var yesButton: UIButton = {
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

    private lazy var noButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(AppColor.Text.inverted, for: .normal)
        button.backgroundColor = AppColor.Background.actionButtonDefault
        button.titleLabel?.font = AppFont.ActayWide.bold(size: 16)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [yesButton, noButton])
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
        self.yesButtonAction = model.yesAction
        self.noButtonAction = model.noAction
        titleLabel.text = model.title

        switch model.alertType {
        case .twoButtons:
            yesButton.isHidden = false
            noButton.isHidden = false
            styleYesButtonAsSecondary()

        case .oneButton:
            yesButton.isHidden = false
            noButton.isHidden = true
            styleYesButtonAsPrimary()
        }
    }

    // MARK: - Private Method

    private func styleYesButtonAsPrimary() {
        yesButton.setTitleColor(AppColor.Text.inverted, for: .normal)
        yesButton.backgroundColor = AppColor.Background.actionButtonDefault
        yesButton.layer.borderWidth = 0
    }

    private func styleYesButtonAsSecondary() {
        yesButton.setTitleColor(AppColor.Background.actionButtonDefault, for: .normal)
        yesButton.backgroundColor = .clear
        yesButton.layer.borderWidth = 1.0
        yesButton.layer.borderColor = AppColor.Background.actionButtonDefault.cgColor
    }

    // MARK: - Actions

    @objc private func yesButtonTapped() {
        yesButtonAction?()
    }

    @objc private func noButtonTapped() {
        noButtonAction?()
    }
}

// MARK: - Constants

private extension CustomAlertView {
    
    func setupUI() {
        [backgroundView, customView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [titleLabel, buttonStack].forEach {
            customView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            customView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),

            buttonStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            buttonStack.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
