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
typealias AppButtonIconView = AppButtonView<AppButtonIcon>
typealias AppButtonActionView = AppButtonView<AppButtonAction>

class AppButtonView<Config: AppButtonConfig>: UIButton {

    // MARK: - Private Properties

    private let styleConfig: Config
    private var onTap: ((AppButtonView<Config>) -> Void)?

    private var needsGradientBorder = false
    private var currentBorderColors: [UIColor] = []
    private var currentCornerRadius: CGFloat = 0
    private var currentBorderWidth: CGFloat = 0

    private struct VisualState {
        let backgroundColor: UIColor
        let textColor: UIColor
        let font: UIFont
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        let borderColor: UIColor
        let tintColor: UIColor
        let gradientBackgroundColors: [UIColor]
        let gradientBorderColors: [UIColor]
        let backgroundEffect: UIView?
    }

    // MARK: - Subviews

    private lazy var actionTitleLabel: UILabel = {
        let view = UILabel()
        let angleDegrees: CGFloat = -7.7
        let angleRadians = angleDegrees * (.pi / 180)
        view.transform = CGAffineTransform(rotationAngle: angleRadians)
        view.textAlignment = .left
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var actionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var gradientBackgroundLayer = CALayer.getGradientLayer()
    private lazy var gradientBorderLayer = CALayer.getGradientLayer()
    private lazy var borderMaskLayer = CAShapeLayer()

    private var activeBackgroundEffect: UIView?

    // MARK: - Initializers

    init(_ config: Config) {
        self.styleConfig = config
        super.init(frame: .zero)

        let config = UIButton.Configuration.plain()
        self.configuration = config

        self.configurationUpdateHandler = { [weak self] button in
            button.configuration = self?.makeConfiguration(for: button.state)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientBackgroundLayer.frame = bounds
        gradientBorderLayer.frame = bounds
        borderMaskLayer.frame = bounds

        if needsGradientBorder {
            applyGradientBorder(
                colors: currentBorderColors,
                cornerRadius: currentCornerRadius,
                borderWidth: currentBorderWidth
            )
        }

        if let newEffect = visualState(for: state)?.backgroundEffect as? GlassEffectView {
            newEffect.frame = bounds
            newEffect.cornerRadius = currentCornerRadius

            if activeBackgroundEffect !== newEffect {
                activeBackgroundEffect?.removeFromSuperview()
                insertSubview(newEffect, at: 0)
                activeBackgroundEffect = newEffect
            }
        } else {
            if let existing = activeBackgroundEffect {
                existing.removeFromSuperview()
                activeBackgroundEffect = nil
            }
        }
    }

    // MARK: - Public Methods

    func setAction(_ action: @escaping (AppButtonView) -> Void) {
        removeTarget(self, action: #selector(didTap), for: .touchUpInside)
        onTap = action
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    // MARK: - Private Methods

    private func makeConfiguration(for state: UIControl.State) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()

        guard let visualState = visualState(for: state) else {
            return config
        }

        config.background.backgroundColor = visualState.backgroundColor
        config.baseBackgroundColor = .clear
        config.background.strokeColor = visualState.borderColor
        config.background.strokeWidth = visualState.borderWidth
        config.background.cornerRadius = visualState.cornerRadius

        config.attributedTitle = attributedTitle(
            title: styleConfig.title ?? "",
            color: visualState.textColor,
            font: visualState.font
        )

        config.image = styleConfig.image

        if !visualState.gradientBackgroundColors.isEmpty {
            applyGradientBackground(
                colors: visualState.gradientBackgroundColors,
                cornerRadius: visualState.cornerRadius
            )
        } else {
            removeGradientBackground()
        }

        if !visualState.gradientBorderColors.isEmpty {
            currentBorderColors = visualState.gradientBorderColors
            currentCornerRadius = visualState.cornerRadius
            currentBorderWidth = visualState.borderWidth
            needsGradientBorder = true
        } else {
            removeGradientBorder()
            needsGradientBorder = false
        }

        if let actionButtonTitle = styleConfig.actionTitle,
           let actionButtonImage = styleConfig.actionImage {
            actionTitleLabel.text = actionButtonTitle
            actionTitleLabel.font = visualState.font
            actionTitleLabel.textColor = visualState.textColor

            actionImageView.image = actionButtonImage
            actionImageView.tintColor = visualState.tintColor

            currentCornerRadius = visualState.cornerRadius

            setupActionLayout()
        }

        self.tintColor = visualState.tintColor

        return config
    }

    private func attributedTitle(
        title: String,
        color: UIColor,
        font: UIFont
    ) -> AttributedString {
        var attributes = AttributeContainer()
        attributes.foregroundColor = color
        attributes.font = font
        return AttributedString(title, attributes: attributes)
    }

    private func visualState(for state: UIControl.State) -> VisualState? {
        guard let style = styleConfig.style(for: state) else {
            return nil
        }

        return VisualState(
            backgroundColor: style.backgroundColor,
            textColor: style.titleColor,
            font: style.font,
            cornerRadius: style.cornerRadius,
            borderWidth: style.borderWidth,
            borderColor: style.borderColor,
            tintColor: style.tintColor,
            gradientBackgroundColors: style.gradientBackgroundColors,
            gradientBorderColors: style.gradientBorderColors,
            backgroundEffect: style.backgroundEffectProvider?()
        )
    }

    // MARK: - Actions

    @objc
    private func didTap() {
        onTap?(self)
    }

    // MARK: - Layout

    private func setupActionLayout() {
        addSubview(actionTitleLabel)
        addSubview(actionImageView)

        setupConstraintsActionTitleLabel()
        setupConstraintsActionImageView()
    }

    // MARK: - Constraints

    private func setupConstraintsActionTitleLabel() {
        NSLayoutConstraint.activate([
            actionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            actionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            actionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }

    private func setupConstraintsActionImageView() {
        NSLayoutConstraint.activate([
            actionImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionImageView.heightAnchor.constraint(equalToConstant: 130),
            actionImageView.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}

// MARK: - Gradient

private extension AppButtonView {
    func applyGradientBackground(colors: [UIColor], cornerRadius: CGFloat) {
        gradientBackgroundLayer.colors = colors.map(\.cgColor)
        gradientBackgroundLayer.frame = bounds
        gradientBackgroundLayer.cornerRadius = cornerRadius
        gradientBackgroundLayer.cornerCurve = .continuous
        gradientBackgroundLayer.masksToBounds = true

        if gradientBackgroundLayer.superlayer == nil || gradientBackgroundLayer.superlayer !== layer {
            layer.insertSublayer(gradientBackgroundLayer, at: 0)
        }
    }

    func removeGradientBackground() {
        gradientBackgroundLayer.removeFromSuperlayer()
        gradientBackgroundLayer.mask = nil
    }

    func applyGradientBorder(
        colors: [UIColor],
        cornerRadius: CGFloat,
        borderWidth: CGFloat
    ) {
        gradientBorderLayer.colors = colors.map(\.cgColor)
        gradientBorderLayer.frame = bounds
        gradientBorderLayer.cornerRadius = 0
        gradientBorderLayer.masksToBounds = true

        let outerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        outerPath.usesEvenOddFillRule = true

        let innerRect = bounds.insetBy(dx: borderWidth, dy: borderWidth)

        let innerCornerRadius = max(cornerRadius - borderWidth, 0)
        let innerPath = UIBezierPath(roundedRect: innerRect, cornerRadius: innerCornerRadius)

        outerPath.append(innerPath)

        borderMaskLayer.frame = gradientBorderLayer.bounds
        borderMaskLayer.path = outerPath.cgPath
        borderMaskLayer.fillRule = .evenOdd
        gradientBorderLayer.mask = borderMaskLayer

        gradientBorderLayer.setNeedsDisplay()

        if gradientBorderLayer.superlayer == nil {
            layer.addSublayer(gradientBorderLayer)
        } else {
            layer.insertSublayer(gradientBorderLayer, above: gradientBackgroundLayer)
        }
    }

    func removeGradientBorder() {
        gradientBorderLayer.removeFromSuperlayer()
        gradientBorderLayer.mask = nil
    }
}
