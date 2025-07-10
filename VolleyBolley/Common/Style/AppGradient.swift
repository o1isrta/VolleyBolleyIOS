import UIKit

/// Градиенты для фона кнопок, иконок и т.п
enum AppGradient {
    static let greenLight = [
        AppColor.Gradient.greenLightStart,
        AppColor.Gradient.greenLightEnd
    ]
}

extension AppGradient {
    static func iconGradientImage(
        systemName: String? = nil,
        named: UIImage? = nil,
        size: CGSize = CGSize(width: 24, height: 24)
    ) -> UIImage? {
        let baseImage: UIImage?

        if let systemName {
            let config = UIImage.SymbolConfiguration(pointSize: size.height, weight: .regular)
            baseImage = UIImage(systemName: systemName, withConfiguration: config)
        } else if let named {
            baseImage = named
        } else {
            return nil
        }

        guard let symbol = baseImage else { return nil }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        gradientLayer.colors = AppGradient.greenLight.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        let imageLayer = CALayer()
        imageLayer.contents = symbol.withRenderingMode(.alwaysTemplate).cgImage
        imageLayer.frame = gradientLayer.bounds
        imageLayer.contentsGravity = .resizeAspect
        gradientLayer.mask = imageLayer

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return renderedImage?.withRenderingMode(.alwaysOriginal)
    }
}
