//
//  AppButtonView.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

final class AppButtonView<T: AppButtonConfig>: UIButton {
    private let config: T
    private var visualState: AppButtonVisualState = .normal {
        didSet {
            applyStyle()
        }
    }

    init(config: T) {
        self.config = config
        super.init(frame: .zero)
        setTitle(config.title, for: .normal)
        applyStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setVisualState(_ state: AppButtonVisualState) {
        self.visualState = state
        isEnabled = (state != .disabled)
    }

    private func applyStyle() {
        let style = config.style(for: visualState)

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
