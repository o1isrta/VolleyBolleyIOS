//
//  UILabel+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 02.08.2025.
//

import UIKit

extension UILabel {

	func setTextWithDifferentStyles(_ texts: [(String, UIFont)]) {
		let attributedString = NSMutableAttributedString()

		for (text, font) in texts {
			let attributes: [NSAttributedString.Key: Any] = [
				.font: font
			]
			attributedString.append(NSAttributedString(string: text, attributes: attributes))
		}

		self.attributedText = attributedString
	}

	func applyGradient(
		textLayerAlignmentMode: CATextLayerAlignmentMode = .left,
		colors: [UIColor] = AppGradient.greenLight
	) {
		// Remove existing gradient layer if any
		layer.sublayers?.forEach { $0.removeFromSuperlayer() }
		// Ensure label has proper bounds
		layoutIfNeeded()
		guard !bounds.isEmpty else { return }
		// Set text color to clear so gradient shows
		textColor = .clear
		// Create gradient layer with left-aligned text
		let gradientLayer = CALayer.makeGradientTextMask(for: self, textLayerAlignmentMode: textLayerAlignmentMode)
		layer.addSublayer(gradientLayer)
	}

    func setRequiredPriorities() {
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
