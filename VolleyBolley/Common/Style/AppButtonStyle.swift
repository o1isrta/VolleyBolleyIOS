//
//  AppButtonStyle.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

struct AppButtonStyle {
    var backgroundColor: UIColor?
    var titleColor: UIColor?
    var font: UIFont?
    var cornerRadius: CGFloat?
    var borderWidth: CGFloat?
    var borderColor: UIColor?
    var tintColor: UIColor?

    // MARK: - Primary

    static let primaryNormal = AppButtonStyle(
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16,
        borderWidth: 1,
        borderColor: AppColor.Border.buttonAction
    )

    static let primarySelected = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimarySelected,
        titleColor: AppColor.Text.inverted,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16
    )

    static let primaryDisabled = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimaryDisabled,
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16
    )

    // MARK: - Secondary

    // TODO: - setup style gradient
    static let secondaryNormal = AppButtonStyle(
        titleColor: AppColor.Text.primary,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 16,
        borderWidth: 1,
        borderColor: AppColor.Border.buttonAction
    )

    static let secondarySelected = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimarySelected,
        titleColor: AppColor.Text.inverted,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 16
    )

    // MARK: - Tertiary

    static let tertiaryNormal = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonMap,
        titleColor: AppColor.Text.inverted,
        font: AppFont.Hero.regular(size: 16),
        cornerRadius: 10
    )

    // MARK: - Action Primary

    static let actionNormal = AppButtonStyle(
        titleColor: AppColor.Text.primary,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16,
        borderWidth: 1,
        borderColor: AppColor.Border.buttonAction
    )

    static let actionSelected = AppButtonStyle(
        backgroundColor: AppColor.Background.buttonPrimarySelected,
        titleColor: AppColor.Text.inverted,
        font: AppFont.ActayWide.bold(size: 16),
        cornerRadius: 16
    )

    // MARK: - Icon

    static let iconNormal = AppButtonStyle(
        tintColor: AppColor.Icon.primary
    )
}
