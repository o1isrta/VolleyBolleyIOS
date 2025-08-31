//
//  GradientLabel.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 25.08.2025.
//
import UIKit

class GradientTextLabel: UILabel {
    var gradientColors: [UIColor] = [] {
        didSet {
            setNeedsLayout()
        }
    }

    private var gradientLayer: CAGradientLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
    }

    private func updateGradient() {
        guard let text = text, !text.isEmpty, bounds.width > 0, bounds.height > 0 else {
            gradientLayer?.removeFromSuperlayer()
            gradientLayer = nil
            return
        }

        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1)
            layer.addSublayer(gradientLayer!)
        }

        gradientLayer?.frame = bounds
        gradientLayer?.colors = gradientColors.map { $0.cgColor }

        textColor = .clear

        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font as Any,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.white
        ]

        let attributedString = NSAttributedString(string: text, attributes: attributes)
        let stringSize = attributedString.size()

        let textRect = CGRect(
            x: 0,
            y: (bounds.height - stringSize.height) / 2,
            width: bounds.width,
            height: stringSize.height
        )

        attributedString.draw(in: textRect)

        if let textImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
            let maskLayer = CALayer()
            maskLayer.contents = textImage
            maskLayer.frame = bounds
            gradientLayer?.mask = maskLayer
        }
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        if let text = text, !text.isEmpty {
            size.width += 2
        }
        return size
    }
}
