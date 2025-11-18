import UIKit

struct GlassConfig {
    var cornerRadius: CGFloat
    var borderColor: CGColor
    var borderWidth: CGFloat
    var tintedBackgroundColor: UIColor
    var blurDensity: CGFloat
    var outerShadowColor: CGColor
    var outerShadowOpacity: Float
    var outerShadowOffset: CGSize
    var outerShadowRadius: CGFloat
    var innerShadowColor: CGColor
    var innerShadowOpacity: Float
    var innerShadowRadius: CGFloat
    var innerShadowOffset: CGSize

    static var standard: GlassConfig {
        GlassConfig(
            cornerRadius: 32,
            borderColor: UIColor.clear.cgColor,
            borderWidth: 0,
            tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.13),
            blurDensity: 0.1,
            outerShadowColor: UIColor.clear.cgColor,
            outerShadowOpacity: 0,
            outerShadowOffset: .zero,
            outerShadowRadius: 0,
            innerShadowColor: AppColor.Glass.innerShadowColor.cgColor,
            innerShadowOpacity: 0.2,
            innerShadowRadius: 8,
            innerShadowOffset: CGSize(width: 0, height: -16)
        )
    }

	static var note: GlassConfig {
		GlassConfig(
			cornerRadius: 16,
            borderColor: UIColor.clear.cgColor,
			borderWidth: 0,
			tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.16),
            blurDensity: 0.1,
            outerShadowColor: AppColor.Glass.outerShadowColor.cgColor,
			outerShadowOpacity: 0.15,
			outerShadowOffset: CGSize(width: 0, height: 8),
			outerShadowRadius: 16,
            innerShadowColor: AppColor.Glass.innerShadowColor.cgColor,
			innerShadowOpacity: 0.3,
			innerShadowRadius: 10.0,
			innerShadowOffset: CGSize(width: 0, height: -18)
		)
	}

    static var notification: GlassConfig {
        GlassConfig(
            cornerRadius: 16,
            borderColor: AppColor.Glass.border.withAlphaComponent(0.4).cgColor,
            borderWidth: 0.0,
            tintedBackgroundColor: AppColor.Glass.tintColor.withAlphaComponent(0.15),
            blurDensity: 0.0,
            outerShadowColor: AppColor.Glass.outerShadowColor.cgColor,
            outerShadowOpacity: 0.0,
            outerShadowOffset: CGSize(width: 0, height: 8),
            outerShadowRadius: 16,
            innerShadowColor: AppColor.Glass.innerShadowColor.cgColor,
            innerShadowOpacity: 0.0,
            innerShadowRadius: 18.0,
            innerShadowOffset: CGSize(width: 0, height: -16)
        )
    }

    static var sketch: GlassConfig {
        GlassConfig(
            cornerRadius: 32,
            borderColor: UIColor.clear.cgColor,
            borderWidth: 0,
            tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.13),
            blurDensity: 0.1,
            outerShadowColor: UIColor.clear.cgColor,
            outerShadowOpacity: 0,
            outerShadowOffset: .zero,
            outerShadowRadius: 0,
            innerShadowColor: AppColor.Glass.innerShadowColor.cgColor,
            innerShadowOpacity: 0.4,
            innerShadowRadius: 8.0,
            innerShadowOffset: CGSize(width: 0, height: -14)
        )
    }

    static var timePicker: GlassConfig {
        GlassConfig(
            cornerRadius: 16,
            borderColor: AppColor.Glass.border.withAlphaComponent(0.15).cgColor,
            borderWidth: 1.0,
            tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.19),
            blurDensity: 0.1,
            outerShadowColor: AppColor.Glass.outerShadowColor.cgColor,
            outerShadowOpacity: 0.15,
            outerShadowOffset: CGSize(width: 0, height: 8),
            outerShadowRadius: 16,
            innerShadowColor: AppColor.Glass.innerShadowColor.cgColor,
            innerShadowOpacity: 0.3,
            innerShadowRadius: 6,
            innerShadowOffset: CGSize(width: 0, height: -4)
        )
    }

    static var price: GlassConfig {
        GlassConfig(
            cornerRadius: 16,
            borderColor: AppColor.Glass.border.withAlphaComponent(0.15).cgColor,
            borderWidth: 1.0,
            tintedBackgroundColor: AppColor.Background.blur.withAlphaComponent(0.19),
            blurDensity: 0.1,
            outerShadowColor: AppColor.Glass.outerShadowColor.cgColor,
            outerShadowOpacity: 0.15,
            outerShadowOffset: CGSize(width: 0, height: 8),
            outerShadowRadius: 16,
            innerShadowColor: AppColor.Glass.innerShadowColor.cgColor,
            innerShadowOpacity: 0.2,
            innerShadowRadius: 18.0,
            innerShadowOffset: CGSize(width: 0, height: -16)
        )
    }

    static var court: GlassConfig {
        GlassConfig(
            cornerRadius: 32,
            borderColor: UIColor.clear.cgColor,
            borderWidth: 0,
            tintedBackgroundColor: AppColor.Background.screen.withAlphaComponent(0.9),
            blurDensity: 0.1,
            outerShadowColor: UIColor.clear.cgColor,
            outerShadowOpacity: 0,
            outerShadowOffset: .zero,
            outerShadowRadius: 0,
            innerShadowColor: AppColor.Glass.innerShadowColor.cgColor,
            innerShadowOpacity: 0.2,
            innerShadowRadius: 8,
            innerShadowOffset: CGSize(width: 0, height: -16)
        )
    }
}
