//
//  GradientLabel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 02.10.2025.
//

import UIKit

class GradientLabel: UILabel {

	private let gradientLayer = CALayer.getGradientLayer()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}

	override func draw(_ rect: CGRect) {
		let textImage = textAsImage()
		gradientLayer.mask = CALayer()
		gradientLayer.mask?.contents = textImage.cgImage
		gradientLayer.mask?.frame = bounds

		if gradientLayer.superlayer == nil {
			layer.addSublayer(gradientLayer)
		}

		textColor = UIColor.clear
	}

	private func textAsImage() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
		defer { UIGraphicsEndImageContext() }
		let originalColor = textColor
		textColor = AppColor.Background.primary
		drawText(in: bounds)
		textColor = originalColor

		return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
	}
}
