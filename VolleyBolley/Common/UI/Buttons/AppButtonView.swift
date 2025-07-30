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

    private var visualState: AppButtonVisualState

    private var currentStyle: AppButtonStyle {
        config.style(for: visualState) ?? config.defaultStyle
    }

    private let borderMaskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()

    private lazy var gradientBackgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.name = "gradientBackground"
        return layer
    }()

    private lazy var gradientBorderLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.name = "gradientBorder"
        return layer
    }()

    // MARK: - Initializers

    init(_ config: T, initialState: AppButtonVisualState = .normal) {
        self.config = config
        self.visualState = initialState
        super.init(frame: .zero)
        setTitle(config.title, for: .normal)
        setImage(config.image, for: .normal)
        applyStyle()
        setupGradientLayersIfNeeded()
        isEnabled = (visualState != .disabled)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyCornerRadius()
        setupGradientFrames()
    }

    // MARK: - Public Methods

    func setVisualState(_ state: AppButtonVisualState) {
        guard visualState != state else { return }
        visualState = state
        isEnabled = (state != .disabled)
        setupGradientLayersIfNeeded()
        applyStyle()
        setNeedsLayout()
    }

    // MARK: - Private Methods

    private func applyStyle() {
        let style = currentStyle

        backgroundColor = style.backgroundColor
        setTitleColor(style.titleColor, for: .normal)
        titleLabel?.font = style.font
        tintColor = style.tintColor
    }

    private func applyCurrentStyle() {
        applyStyle()
        setNeedsLayout()
    }

    private func applyCornerRadius() {
        let radius = currentStyle.cornerRadius ?? 0

        layer.cornerRadius = radius

        // debug
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.red.cgColor
    }

    // MARK: - Gradients

    private func setupGradientLayersIfNeeded() {
        if gradientBackgroundLayer.superlayer == nil {
            layer.insertSublayer(gradientBackgroundLayer, at: 0)
        }

        if gradientBorderLayer.superlayer == nil {
            layer.addSublayer(gradientBorderLayer)
            gradientBorderLayer.mask = borderMaskLayer
        }
    }

    private func setupGradientFrames() {
        let style = currentStyle
        let cornerRadius = style.cornerRadius ?? 0
        let borderWidth = style.borderWidth ?? 0

        if let colors = style.gradientBackgroundColors {
            updateBackgroundGradient(
                colors: colors,
                cornerRadius: cornerRadius
            )
        }

        if let colors = style.gradientBorderColors {
            updateBorderGradient(
                colors: colors,
                cornerRadius: cornerRadius,
                borderWidth: borderWidth
            )
        }
    }

    private func updateBackgroundGradient(colors: [UIColor], cornerRadius: CGFloat) {
        gradientBackgroundLayer.colors = colors.map(\.cgColor)
        gradientBackgroundLayer.frame = bounds
        gradientBackgroundLayer.cornerRadius = cornerRadius
        gradientBackgroundLayer.cornerCurve = .continuous
        gradientBackgroundLayer.masksToBounds = true

        if gradientBackgroundLayer.superlayer == nil || gradientBackgroundLayer.superlayer !== layer {
            layer.insertSublayer(gradientBackgroundLayer, at: 0)
        }
    }

    // TODO: - Fix corderRadius
    private func updateBorderGradient(
        colors: [UIColor],
        cornerRadius: CGFloat,
        borderWidth: CGFloat
    ) {
        gradientBorderLayer.colors = colors.map(\.cgColor)
        gradientBorderLayer.frame = bounds

        let path = UIBezierPath(
            roundedRect: bounds.insetBy(dx: borderWidth / 2, dy: borderWidth / 2),
            cornerRadius: cornerRadius
        ).cgPath

        borderMaskLayer.frame = bounds
        borderMaskLayer.path = path
        borderMaskLayer.fillColor = UIColor.clear.cgColor
        borderMaskLayer.strokeColor = UIColor.black.cgColor
        borderMaskLayer.lineWidth = borderWidth

        if let shapeMask = gradientBorderLayer.mask as? CAShapeLayer {
            print("shapeMask.frame:", shapeMask.frame)
            print("shapeMask.path bounds:", shapeMask.path?.boundingBox ?? .zero)
        }
    }
}
