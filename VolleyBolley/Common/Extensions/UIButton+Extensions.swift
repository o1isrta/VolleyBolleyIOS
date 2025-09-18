//
//  UIButton+Extensions.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 02.09.2025.
//

import UIKit

extension UIButton {
    /// Applies gradient to the button text with optional underline
    /// - Parameters:
    ///   - colors: Array of colors for the gradient (default: AppGradient.greenLight)
    ///   - withUnderline: Whether to add underline to the text (default: false)
    ///   - alignment: Text alignment mode (default: .left)
    func applyTextGradient(
        colors: [UIColor] = AppGradient.greenLight,
        withUnderline: Bool = false,
        alignment: CATextLayerAlignmentMode = .left
    ) {
        // Ensure button has proper bounds
        layoutIfNeeded()
        // Check for valid bounds and minimum size
        guard
            !bounds.isEmpty,
            let text = title(for: .normal),
            !text.isEmpty
        else {
            return
        }
        // Create gradient with text
        let gradientLayer = createGradientTextMask(
            text: text,
            colors: colors,
            withUnderline: withUnderline,
            alignment: alignment
        )
        layer.addSublayer(gradientLayer)
        setTitleColor(.clear, for: .normal)
    }

    private func createGradientTextMask(
        text: String,
        colors: [UIColor],
        withUnderline: Bool,
        alignment: CATextLayerAlignmentMode
    ) -> CAGradientLayer {
        let gradient = CALayer.getGradientLayer(with: colors)
        gradient.frame = bounds
        let textLayer = CATextLayer()
        var attributes: [NSAttributedString.Key: Any] = [
            .font: titleLabel?.font as Any,
            .foregroundColor: UIColor.black
        ]
        // Add underline if requested
        if withUnderline {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        textLayer.string = attributedString
        textLayer.frame = bounds
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = alignment
        textLayer.truncationMode = .end

        gradient.mask = textLayer
        return gradient
    }
}
