//
//  AppButtonView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

typealias AppButtonPrimaryView = AppButtonView<AppButtonPrimary>
typealias AppButtonSecondaryView = AppButtonView<AppButtonSecondary>
typealias AppButtonTertiaryView = AppButtonView<AppButtonTertiary>
typealias AppButtonActionView = AppButtonView<AppButtonAction>
typealias AppButtonIconView = AppButtonView<AppButtonIcon>

final class AppButtonView<T: AppButtonConfig>: UIButton {

    // MARK: - Private Properties

    private let config: T

    private var visualState: AppButtonVisualState {
        didSet {
            applyStyle()
        }
    }

    // MARK: - Initializers

    init(_ config: T, initialState: AppButtonVisualState = .normal) {
        self.config = config
        self.visualState = initialState
        super.init(frame: .zero)
        setTitle(config.title, for: .normal)
        setImage(config.image, for: .normal)
        applyStyle()
        isEnabled = (visualState != .disabled)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func setVisualState(_ state: AppButtonVisualState) {
        self.visualState = state
        isEnabled = (state != .disabled)
    }

    // MARK: - Private Methods

    private func applyStyle() {
        let style = config.style(for: visualState) ?? config.defaultStyle

        if let cornerRadius = style.cornerRadius {
            layer.cornerRadius = cornerRadius
        }

        backgroundColor = style.backgroundColor
        setTitleColor(style.titleColor, for: .normal)
        titleLabel?.font = style.font

        layer.borderWidth = style.borderWidth ?? 0
        layer.borderColor = style.borderColor?.cgColor
    }
}
