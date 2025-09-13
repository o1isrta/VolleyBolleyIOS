//
//  YellowButtonStyle.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.08.2025.
//

import UIKit

struct YellowButtonStyle {

    var backgroundColor: UIColor = .clear
    var titleColor: UIColor
    var font: UIFont = AppFont.ActayWide.bold(size: 16)
    var cornerRadius: CGFloat = 16
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = .clear
    var contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 16, trailing: 10)
}

enum YellowButtonStateStyle {

    case normal, selected, disabled, highlightedNormal, highlightedSelected

    var style: YellowButtonStyle {
        switch self {
        case .normal:
            return YellowButtonStyle(
                titleColor: AppColor.Text.primary,
                borderWidth: 1,
                borderColor: AppColor.Border.buttonAction
            )
        case .selected:
            return YellowButtonStyle(
                backgroundColor: AppColor.Background.buttonYellowSelected,
                titleColor: AppColor.Text.inverted
            )
        case .disabled:
            return YellowButtonStyle(
                backgroundColor: AppColor.Background.buttonYellowDisabled,
                titleColor: AppColor.Text.primary
            )
        case .highlightedNormal:
            return YellowButtonStyle(
                titleColor: AppColor.Text.primary,
                borderWidth: 1,
                borderColor: AppColor.Border.buttonAction.withAlphaComponent(0.5)
            )
        case .highlightedSelected:
            return YellowButtonStyle(
                backgroundColor: AppColor.Background.buttonYellowSelected.withAlphaComponent(0.5),
                titleColor: AppColor.Text.inverted
            )
        }
    }
}
