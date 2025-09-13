import UIKit

/// Градиенты для фона кнопок, иконок и т.п
enum AppGradient {
    static let greenLight = [
        AppColor.Gradient.greenLightStart,
        AppColor.Gradient.greenLightEnd
    ]

    static let greenLightWithAlpha = [
        AppColor.Gradient.greenLightStart.withAlphaComponent(0.5),
        AppColor.Gradient.greenLightEnd.withAlphaComponent(0.5)
    ]
}
