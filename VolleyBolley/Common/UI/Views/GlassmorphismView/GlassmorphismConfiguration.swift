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

	static var sketch: GlassmorphismConfiguration {
		GlassmorphismConfiguration(
			cornerRadius: 32,
			borderColor: UIColor.clear,
			borderWidth: 0,
			tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.13),
			blurIntensity: 0.1,
			theme: .light,
			outerShadowColor: UIColor.clear,
			outerShadowOpacity: 0,
			outerShadowOffset: .zero,
			outerShadowRadius: 0,
			innerShadowColor: AppColor.Glassmorphism.innerShadowColor,
			innerShadowOpacity: 0.4,
			innerShadowRadius: 8.0,
			innerShadowOffset: CGSize(width: 0, height: -14)
		)
	}

	static var timePicker: GlassmorphismConfiguration {
		GlassmorphismConfiguration(
			cornerRadius: 16,
			borderColor: AppColor.Glassmorphism.border.withAlphaComponent(0.15),
			borderWidth: 1.0,
			tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.19),
			blurIntensity: 0.2,
			theme: .light,
			outerShadowColor: AppColor.Glassmorphism.outerShadowColor,
			outerShadowOpacity: 0.15,
			outerShadowOffset: CGSize(width: 0, height: 8),
			outerShadowRadius: 16,
			innerShadowColor: AppColor.Glassmorphism.innerShadowColor,
			innerShadowOpacity: 0.2,
			innerShadowRadius: 6,
			innerShadowOffset: CGSize(width: 0, height: -4)
		)
	}

	static var price: GlassmorphismConfiguration {
		GlassmorphismConfiguration(
			cornerRadius: 16,
			borderColor: AppColor.Glassmorphism.border.withAlphaComponent(0.15),
			borderWidth: 1.0,
			tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.19),
			blurIntensity: 0.1,
			theme: .light,
			outerShadowColor: AppColor.Glassmorphism.outerShadowColor,
			outerShadowOpacity: 0.15,
			outerShadowOffset: CGSize(width: 0, height: 8),
			outerShadowRadius: 16,
			innerShadowColor: AppColor.Glassmorphism.innerShadowColor,
			innerShadowOpacity: 0.2,
			innerShadowRadius: 18.0,
			innerShadowOffset: CGSize(width: 0, height: -16)
		)
	}

	static var message: GlassmorphismConfiguration {
		GlassmorphismConfiguration(
			cornerRadius: 16,
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
            cornerRadius: 16,
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
