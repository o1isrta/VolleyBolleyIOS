//
//  GreenButtonStyle.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.08.2025.
//

import UIKit

struct GreenButtonStyle {
    var titleColor: UIColor = AppColor.Text.primary
    var font: UIFont = AppFont.Hero.regular(size: 16)
    var cornerRadius: CGFloat = 14
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = .clear
    var tintColor: UIColor = AppColor.Icon.primary
    var gradientTintColor: [UIColor] = []
    var gradientBackgroundColors: [UIColor] = []
    var gradientBorderColors: [UIColor] = []

    let contentInsets = NSDirectionalEdgeInsets(
        top: 12,
        leading: 12,
        bottom: 12,
        trailing: 12
    )

    let trailingImageContentInsets = NSDirectionalEdgeInsets(
        top: 12,
        leading: 12,
        bottom: 12,
        trailing: 6
    )
    let trailingImagePadding: CGFloat = 8
    let trailingImageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)

    let topImageFont: UIFont = AppFont.Hero.regular(size: 14)
    let topImagePadding: CGFloat = 1
    let topImageContentInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
}

enum GreenButtonStateStyle {

    case normal, selected, highlightedNormal, highlightedSelected

    var style: GreenButtonStyle {
        switch self {
        case .normal:
            return GreenButtonStyle(
                titleColor: AppColor.Text.primary,
                cornerRadius: 14,
                borderWidth: 1,
                borderColor: AppColor.Border.buttonAction,
                tintColor: AppColor.Icon.primary,
                gradientTintColor: AppGradient.greenLight,
                gradientBorderColors: AppGradient.greenLight
            )
        case .selected:
            return GreenButtonStyle(
                titleColor: AppColor.Text.inverted,
                cornerRadius: 16,
                tintColor: AppColor.Icon.inverted,
                gradientBackgroundColors: AppGradient.greenLight
            )
        case .highlightedNormal:
            return GreenButtonStyle(
                titleColor: AppColor.Text.primary,
                cornerRadius: 14,
                borderWidth: 1,
                tintColor: AppColor.Icon.primary,
                gradientTintColor: AppGradient.greenLightWithAlpha,
                gradientBorderColors: AppGradient.greenLightWithAlpha
            )
        case .highlightedSelected:
            return GreenButtonStyle(
                titleColor: AppColor.Text.inverted,
                cornerRadius: 16,
                tintColor: AppColor.Icon.inverted,
                gradientBackgroundColors: AppGradient.greenLightWithAlpha
            )
        }
    }
}
