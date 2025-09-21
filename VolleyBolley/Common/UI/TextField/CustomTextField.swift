//
//  CustomTextField.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 18.09.2025.
//

import UIKit

final class CustomTextField: UITextField {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let fontSize: CGFloat = 16
        static let defaultLeftPadding: CGFloat = 16
        static let height: CGFloat = 51
    }

    // MARK: - Initializers

    init(
        placeholder: String? = nil,
        alignment: NSTextAlignment = .left,
        keyboardType: UIKeyboardType = .default,
        leftPadding: CGFloat = Constants.defaultLeftPadding
    ) {
        super.init(frame: .zero)
        configure(
            placeholder: placeholder,
            alignment: alignment,
            keyboardType: keyboardType,
            leftPadding: leftPadding
        )
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func configure(
        placeholder: String? = nil,
        alignment: NSTextAlignment = .left,
        keyboardType: UIKeyboardType = .default,
        leftPadding: CGFloat
    ) {
        self.placeholder = placeholder
        self.textAlignment = alignment
        self.keyboardType = keyboardType
        self.backgroundColor = AppColor.Background.primary
        self.layer.cornerRadius = Constants.cornerRadius
        self.textColor = AppColor.Text.placeHolder
        self.font = AppFont.Hero.regular(size: Constants.fontSize)

        // если leftPadding > 0 — ставим отступ, иначе оставляем для центрирования
        if leftPadding > 0 {
            self.setLeftPaddingPoints(leftPadding)
        }
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
    }
}
