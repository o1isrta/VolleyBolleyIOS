//
//  GradientTextButton.swift
//  VolleyBolley
//
//  Created by Олег Кор on 27.08.2025.
//
import UIKit

class GradientTextButton: UIButton {

    // MARK: - Properties
    var textGradientColors: [CGColor] = [] {
        didSet {
            setNeedsLayout()
        }
    }

    var textGradientStartPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            setNeedsLayout()
        }
    }

    var textGradientEndPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
    }

    // MARK: - Private Methods
    private func updateGradient() {
        layer.sublayers?
            .filter { $0 is CAGradientLayer }
            .forEach { $0.removeFromSuperlayer() }

        guard !textGradientColors.isEmpty,
              bounds.width > 0,
              bounds.height > 0,
              let title = title(for: .normal),
              !title.isEmpty else {
            return
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = textGradientColors
        gradientLayer.startPoint = textGradientStartPoint
        gradientLayer.endPoint = textGradientEndPoint
        gradientLayer.frame = bounds

        if let maskImage = createTextMaskImage() {
            let maskLayer = CALayer()
            maskLayer.contents = maskImage
            maskLayer.frame = bounds
            gradientLayer.mask = maskLayer
        }

        layer.addSublayer(gradientLayer)
        setTitleColor(.clear, for: .normal)
    }

    private func createTextMaskImage() -> CGImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext(),
              let title = title(for: .normal),
              let font = titleLabel?.font else {
            return nil
        }

        context.clear(bounds)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]

        let attributedString = NSAttributedString(string: title, attributes: attributes)
        let textSize = attributedString.size()

        let textRect = CGRect(
            x: (bounds.width - textSize.width) / 2,
            y: (bounds.height - textSize.height) / 2,
            width: textSize.width,
            height: textSize.height
        )

        attributedString.draw(in: textRect)

        return UIGraphicsGetImageFromCurrentImageContext()?.cgImage
    }

    deinit {
        layer.sublayers?
            .filter { $0 is CAGradientLayer }
            .forEach { $0.removeFromSuperlayer() }

        print("💥 GradientTextButton deallocated")
    }
}
