//
//  AppButtonStyle.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

struct AppButtonStyle {
    var backgroundColor: UIColor
    var titleColor: UIColor
    var font: UIFont
    var cornerRadius: CGFloat
    var borderWidth: CGFloat
    var borderColor: UIColor
    var tintColor: UIColor
    var gradientBackgroundColors: [UIColor]
    var gradientBorderColors: [UIColor]
    var backgroundEffectProvider: (() -> UIView?)?

    // MARK: - Primary

    static let primaryNormal = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16,
        borderWidth: 1,
        borderColor: AppColor.Border.buttonAction,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let primarySelected = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimarySelected,
        titleColor: AppColor.Text.inverted,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let primaryDisabled = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimaryDisabled,
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let primaryHighlightedNormal = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16,
        borderWidth: 1,
        borderColor: AppColor.Border.buttonAction.withAlphaComponent(0.5),
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let primaryHighlightedSelected = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimarySelected.withAlphaComponent(0.5),
        titleColor: AppColor.Text.inverted,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    // MARK: - Secondary

    static let secondaryNormal = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.primary,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 14,
        borderWidth: 1,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: AppGradient.greenLight
    )

    static let secondarySelected = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.inverted,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 16,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: AppGradient.greenLight,
        gradientBorderColors: []
    )

    static let secondaryHighlightedNormal = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.primary,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 14,
        borderWidth: 1,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: [
            AppColor.Gradient.greenLightStart.withAlphaComponent(0.5),
            AppColor.Gradient.greenLightEnd.withAlphaComponent(0.5)
        ]
    )

    static let secondaryHighlightedSelected = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.inverted,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 16,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [
            AppColor.Gradient.greenLightStart.withAlphaComponent(0.5),
            AppColor.Gradient.greenLightEnd.withAlphaComponent(0.5)
        ],
        gradientBorderColors: []
    )

    // TODO: - Add secondary with arrow icon and changeLevel button style

    // MARK: - Tertiary

    static let tertiaryNormal = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonMap,
        titleColor: AppColor.Text.inverted,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 10,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let tertiaryHighlighted = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonMap.withAlphaComponent(0.7),
        titleColor: AppColor.Text.inverted,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 10,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: .clear,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    // MARK: - Icon

    static let iconNormal = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: .clear,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 0,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.primary,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let iconSelected = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: .clear,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 0,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.inverted,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let iconHighlightedNormal = AppButtonStyle(
        backgroundColor: .lightGray.withAlphaComponent(0.3),
        titleColor: .clear,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 8,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.primary.withAlphaComponent(0.7),
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let iconHighlightedSelected = AppButtonStyle(
        backgroundColor: .lightGray.withAlphaComponent(0.3),
        titleColor: .clear,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 10,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.inverted.withAlphaComponent(0.7),
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    // MARK: - Action Primary

    static let actionNormal = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 24),
        cornerRadius: 32,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.primary,
        gradientBackgroundColors: [],
        gradientBorderColors: [],
        backgroundEffectProvider: { AppEffect.glass() }
    )

    static let actionSelected = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimarySelected,
        titleColor: AppColor.Text.inverted,
        font: AppFont.ActayWide.bold(size: 24),
        cornerRadius: 32,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.primary,
        gradientBackgroundColors: [],
        gradientBorderColors: []
    )

    static let actionHighlightedNormal = AppButtonStyle(
        backgroundColor: .clear,
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 24),
        cornerRadius: 32,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.primary,
        gradientBackgroundColors: [],
        gradientBorderColors: [],
        backgroundEffectProvider: { AppEffect.glassHightLighted() }
    )

    static let actionHighlightedSelected = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimarySelected.withAlphaComponent(0.7),
        titleColor: AppColor.Text.inverted,
        font: AppFont.ActayWide.bold(size: 24),
        cornerRadius: 32,
        borderWidth: 0,
        borderColor: .clear,
        tintColor: AppColor.Icon.primary,
        gradientBackgroundColors: [],
        gradientBorderColors: [],
    )
}
