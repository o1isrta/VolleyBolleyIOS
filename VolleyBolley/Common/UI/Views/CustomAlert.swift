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

    private lazy var doneButton: AppButtonPrimaryView = {
        let button = AppButtonPrimaryView(.done)
        button.setAction(self.didTapDoneButton)
        return button
    }()

    private lazy var cancelButton: AppButtonPrimaryView = {
        let button = AppButtonPrimaryView(.cancel)
        button.isSelected = true
        button.setAction(self.didTapCancelButton)
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

    @available(*, unavailable)
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

        case .oneButton:
            doneButton.isHidden = false
            doneButton.isSelected = true
            cancelButton.isHidden = true
            doneActionButton = model.doneAction
        }
    }

    // MARK: - Private Method

    private func didTapDoneButton(_ button: AppButtonPrimaryView) {
        doneActionButton?()
    }

    private func didTapCancelButton(_ button: AppButtonPrimaryView) {
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

// MARK: - Preview

#if DEBUG
import SwiftUI

struct CustomUIViewPreview: UIViewRepresentable {
    let model: CustomAlertModel

    func makeUIView(context: Context) -> UIView {
        let view = CustomAlertView()
        view.configure(with: model)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct CustomUIViewPreview_Previews: PreviewProvider {
    static var oneButtonPreview: some View {
        CustomUIViewPreview(model: CustomAlertModel(
            title: "One Button Alert",
            doneAction: nil,
            cancelAction: nil,
            alertType: .oneButton
        ))
        .previewDisplayName("One Button Alert")
    }

    static var twoButtonsPreview: some View {
        CustomUIViewPreview(model: CustomAlertModel(
            title: "Two Buttons Alert",
            doneAction: nil,
            cancelAction: nil,
            alertType: .twoButtons
        ))
        .previewDisplayName("Two Buttons Alert")
    }

    static var previews: some View {
        Group {
            oneButtonPreview
            twoButtonsPreview
        }
    }
}
#endif
