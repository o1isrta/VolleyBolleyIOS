//
//  GreenButton.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.08.2025.
//

import UIKit

/// A customizable UIButton subclass styled with a green theme, supporting gradient backgrounds,
/// borders, and icons.
///
/// `GreenButton` offers enhanced appearance options, including gradient backgrounds, gradient
/// borders, and gradient-tinted icons. It is designed for use within UIKit-based interfaces and
/// adopts a flexible configuration system for different control states such as normal, selected,
/// and highlighted.
///
/// - Features:
///   - Configurable image placement (top, trailing, etc.).
///   - Styled title and image with customizable fonts and colors.
///   - Gradient background and border support, including rounded corners.
///   - Accessibility support as a standard button element.
///
/// - Usage:
///   Create a button using `GreenButton(imagePlacement:)`, optionally specifying image placement.
///   The button adapts its appearance based on state and style configuration.
///
final class GreenButton: UIButton {

    private let imagePlacement: NSDirectionalRectEdge?

    // MARK: - Private Properties

    private var currentBorderStyle: (colors: [UIColor], width: CGFloat)?
    private var lastBounds: CGRect = .zero

    private static var gradientIconCache = NSCache<NSString, UIImage>()

    private let gradientBackgroundLayer = CALayer.getGradientLayer()
    private let gradientBorderLayer = CALayer.getGradientLayer()
    private let borderMaskLayer = CAShapeLayer()

    // MARK: - Initializers

    init(imagePlacement: NSDirectionalRectEdge? = nil) {
        self.imagePlacement = imagePlacement
        super.init(frame: .zero)

        configuration = UIButton.Configuration.plain()

        configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            button.configuration = self.configuration(for: button.state)
        }

        setupLayers()
        setupAccessibility()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateIfBoundsChanged()
    }

    // MARK: - Private Methods

    private func configuration(for state: UIControl.State) -> UIButton.Configuration {
        let style = resolveStyle(for: state)
        var config = UIButton.Configuration.plain()
        config.buttonSize = .medium

        if let imagePlacement {
            config.imagePlacement = imagePlacement
        }

        configureTitle(style: style, state: state, config: &config)
        configureImage(style: style, state: state, config: &config)
        configureBackground(style: style, config: &config)
        configureBorder(style: style, config: &config)

        tintColor = style.tintColor

        return config
    }

    private func resolveStyle(for state: UIControl.State) -> GreenButtonStyle {
        switch (state.contains(.selected), state.contains(.highlighted)) {
        case (true, true): return GreenButtonStateStyle.highlightedSelected.style
        case (true, false): return GreenButtonStateStyle.selected.style
        case (false, true): return GreenButtonStateStyle.highlightedNormal.style
        default: return GreenButtonStateStyle.normal.style
        }
    }

    func configureTitle(
        style: GreenButtonStyle,
        state: UIControl.State,
        config: inout UIButton.Configuration
    ) {
        var attributes = AttributeContainer()
        let font = (config.imagePlacement == .top) ? style.topImageFont : style.font
        attributes.font = font
        attributes.foregroundColor = style.titleColor
        config.attributedTitle = AttributedString(title(for: state) ?? "", attributes: attributes)
    }

    func configureImage(style: GreenButtonStyle, state: UIControl.State, config: inout UIButton.Configuration) {
        switch config.imagePlacement {
        case .top:
            if let image = image(for: state) {
                config.image = style.gradientTintColor.isEmpty
                    ? image
                    : makeGradientIcon(image, colors: style.gradientTintColor)
            }
            config.imagePadding = style.topImagePadding
            config.contentInsets = style.topImageContentInsets
        case .trailing:
            config.image = image(for: state)
            config.imagePadding = style.trailingImagePadding
            config.preferredSymbolConfigurationForImage = style.trailingImageConfig
            config.contentInsets = style.trailingImageContentInsets
        default:
            config.contentInsets = style.contentInsets
        }
    }

    private func configureBorder(style: GreenButtonStyle, config: inout UIButton.Configuration) {
        config.background.strokeColor = .clear
        config.background.cornerRadius = style.cornerRadius

        if !style.gradientBorderColors.isEmpty {
            currentBorderStyle = (colors: style.gradientBorderColors, width: style.borderWidth)
        } else {
            currentBorderStyle = nil
            gradientBorderLayer.isHidden = true
        }
    }

    private func configureBackground(style: GreenButtonStyle, config: inout UIButton.Configuration) {
        config.baseBackgroundColor = .clear

        if !style.gradientBackgroundColors.isEmpty {
            applyGradientBackground(colors: style.gradientBackgroundColors, cornerRadius: style.cornerRadius)
        } else {
            gradientBackgroundLayer.isHidden = true
        }
    }
}

// MARK: - Gradient Helpers

private extension GreenButton {

    func setupLayers() {
        layer.insertSublayer(gradientBackgroundLayer, at: 0)
        layer.insertSublayer(gradientBorderLayer, above: gradientBackgroundLayer)
        gradientBorderLayer.mask = borderMaskLayer
        gradientBackgroundLayer.isHidden = true
        gradientBorderLayer.isHidden = true
    }

    func updateIfBoundsChanged() {
        updateGradientBorderIfNeeded()

        guard bounds != lastBounds else { return }
        lastBounds = bounds

        gradientBackgroundLayer.frame = bounds
        gradientBorderLayer.frame = bounds
        borderMaskLayer.frame = bounds
    }

    func applyGradientBackground(colors: [UIColor], cornerRadius: CGFloat) {
        gradientBackgroundLayer.isHidden = false
        gradientBackgroundLayer.colors = colors.map(\.cgColor)
        gradientBackgroundLayer.cornerRadius = cornerRadius
        gradientBackgroundLayer.cornerCurve = .continuous
        gradientBackgroundLayer.masksToBounds = true
    }

    func applyGradientBorder(colors: [UIColor], borderWidth: CGFloat, cornerRadius: CGFloat) {
        gradientBorderLayer.isHidden = false
        gradientBorderLayer.colors = colors.map(\.cgColor)

        let outerPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        outerPath.usesEvenOddFillRule = true

        let innerRect = bounds.insetBy(dx: borderWidth, dy: borderWidth)
        let innerCornerRadius = max(cornerRadius - borderWidth, 0)
        let innerPath = UIBezierPath(roundedRect: innerRect, cornerRadius: innerCornerRadius)

        outerPath.append(innerPath)
        borderMaskLayer.path = outerPath.cgPath
        borderMaskLayer.fillRule = .evenOdd
    }

    private func updateGradientBorderIfNeeded() {
        guard
            let borderStyle = currentBorderStyle,
            let config = configuration
        else {
            return
        }

        applyGradientBorder(
            colors: borderStyle.colors,
            borderWidth: borderStyle.width,
            cornerRadius: config.background.cornerRadius
        )
    }

    func makeGradientIcon(_ icon: UIImage, colors: [UIColor]) -> UIImage {
        let colorsKey = colors.map { "\($0.cgColor.hashValue)" }.joined(separator: "_")
        let baseKey = "\(icon.size.width)x\(icon.size.height)_\(colorsKey)"
        let cacheKey = baseKey as NSString

        if let cached = Self.gradientIconCache.object(forKey: cacheKey) {
            return cached
        }

        let gradientLayer = CALayer.makeGradientIconMask(
            image: icon,
            size: icon.size,
            colors: colors
        )
        let finalImage = gradientLayer.toUIImage()
        Self.gradientIconCache.setObject(finalImage, forKey: cacheKey)
        return finalImage
    }
}

// MARK: - Accessibility

private extension GreenButton {
    func setupAccessibility() {
        isAccessibilityElement = true
        accessibilityTraits = .button
    }
}

// MARK: - Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview() {
    GreenButtonPreviewVC()
}
#endif
