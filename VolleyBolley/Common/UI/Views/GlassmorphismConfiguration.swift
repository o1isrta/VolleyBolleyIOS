import UIKit

struct GlassmorphismConfiguration {
    var cornerRadius: CGFloat
    var borderColor: UIColor
    var borderWidth: CGFloat
    var tintedBackgroundColor: UIColor
    var blurIntensity: CGFloat
    var theme: GlassmorphismView.Theme
    var outerShadowColor: UIColor?
    var outerShadowOpacity: Float
    var outerShadowOffset: CGSize
    var outerShadowRadius: CGFloat
    var innerShadowColor: UIColor
    var innerShadowOpacity: Float
    var innerShadowRadius: CGFloat
    var innerShadowOffset: CGSize

    init(
        cornerRadius: CGFloat,
        borderColor: UIColor,
        borderWidth: CGFloat,
        tintedBackgroundColor: UIColor,
        blurIntensity: CGFloat,
        theme: GlassmorphismView.Theme,
        outerShadowColor: UIColor?,
        outerShadowOpacity: Float,
        outerShadowOffset: CGSize,
        outerShadowRadius: CGFloat,
        innerShadowColor: UIColor,
        innerShadowOpacity: Float,
        innerShadowRadius: CGFloat,
        innerShadowOffset: CGSize
    ) {
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.tintedBackgroundColor = tintedBackgroundColor
        self.blurIntensity = blurIntensity
        self.theme = theme
        self.outerShadowColor = outerShadowColor
        self.outerShadowOpacity = outerShadowOpacity
        self.outerShadowOffset = outerShadowOffset
        self.outerShadowRadius = outerShadowRadius
        self.innerShadowColor = innerShadowColor
        self.innerShadowOpacity = innerShadowOpacity
        self.innerShadowRadius = innerShadowRadius
        self.innerShadowOffset = innerShadowOffset
    }

    static var standard: GlassmorphismConfiguration {
        GlassmorphismConfiguration(
            cornerRadius: 32,
            borderColor: AppColor.Glassmorphism.border.withAlphaComponent(0.15),
            borderWidth: 1.0,
            tintedBackgroundColor: AppColor.Background.blur,
            blurIntensity: 0.2,
            theme: .light,
            outerShadowColor: AppColor.Glassmorphism.outerShadowColor,
            outerShadowOpacity: 0.15,
            outerShadowOffset: CGSize(width: 0, height: 8),
            outerShadowRadius: 16,
            innerShadowColor: AppColor.Glassmorphism.innerShadowColor,
            innerShadowOpacity: 0.3,
            innerShadowRadius: 18.0,
            innerShadowOffset: CGSize(width: 0, height: -16)
        )
    }

    static var notification: GlassmorphismConfiguration {
        GlassmorphismConfiguration(
            cornerRadius: 32,
            borderColor: AppColor.Glassmorphism.border.withAlphaComponent(0.4),
            borderWidth: 0.0,
            tintedBackgroundColor: AppColor.Glassmorphism.tintColor.withAlphaComponent(0.15),
            blurIntensity: 0.0,
            theme: .light,
            outerShadowColor: AppColor.Glassmorphism.outerShadowColor,
            outerShadowOpacity: 0.0,
            outerShadowOffset: CGSize(width: 0, height: 8),
            outerShadowRadius: 16,
            innerShadowColor: AppColor.Glassmorphism.innerShadowColor,
            innerShadowOpacity: 0.0,
            innerShadowRadius: 18.0,
            innerShadowOffset: CGSize(width: 0, height: -16)
        )
    }
}

extension GlassmorphismView {
    func apply(_ configuration: GlassmorphismConfiguration) {
        cornerRadius = configuration.cornerRadius
        borderColor = configuration.borderColor
        borderWidth = configuration.borderWidth
        tintedBackgroundColor = configuration.tintedBackgroundColor
        setBlurIntensity(configuration.blurIntensity)
        setTheme(configuration.theme)
        outerShadowColor = configuration.outerShadowColor
        outerShadowOpacity = configuration.outerShadowOpacity
        outerShadowOffset = configuration.outerShadowOffset
        outerShadowRadius = configuration.outerShadowRadius
        innerShadowColor = configuration.innerShadowColor
        innerShadowOpacity = configuration.innerShadowOpacity
        innerShadowRadius = configuration.innerShadowRadius
        innerShadowOffset = configuration.innerShadowOffset
    }

    convenience init(configuration: GlassmorphismConfiguration) {
        self.init(frame: .zero)
        apply(configuration)
    }
}
