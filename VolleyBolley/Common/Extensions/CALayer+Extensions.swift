//
//  CALayer+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 04.07.2025.
//

import UIKit

extension CALayer {

	static func getGradientLayer(with colors: [UIColor] = AppGradient.greenLight) -> CAGradientLayer {
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = colors.map { $0.cgColor }
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

		return gradientLayer
	}

	static func makeGradientTextMask(
		for label: UILabel,
		textLayerAlignmentMode: CATextLayerAlignmentMode = .center,
		colors: [UIColor] = AppGradient.greenLight
	) -> CAGradientLayer {
		let gradient = getGradientLayer(with: colors)
		gradient.frame = label.bounds

		let textLayer = CATextLayer()
		textLayer.string = NSAttributedString(
			string: label.text ?? "",
			attributes: [
				.font: label.font as Any,
				.foregroundColor: UIColor.black
			]
		)
		textLayer.frame = label.bounds
		textLayer.contentsScale = UIScreen.main.scale
		textLayer.alignmentMode = textLayerAlignmentMode
		textLayer.truncationMode = .end

		gradient.mask = textLayer
		return gradient
	}

	static func makeGradientIconMask(
		image: UIImage?,
		size: CGSize,
		colors: [UIColor] = AppGradient.greenLight
	) -> CAGradientLayer {
		let gradient = getGradientLayer(with: colors)
		gradient.frame = CGRect(origin: .zero, size: size)

		let maskLayer = CALayer()
		maskLayer.contents = image?.cgImage
		maskLayer.frame = gradient.bounds
		maskLayer.contentsGravity = .resizeAspect

		gradient.mask = maskLayer
		return gradient
	}

	func toUIImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: bounds.size)
		return renderer.image { ctx in
			render(in: ctx.cgContext)
		}
	}
}
