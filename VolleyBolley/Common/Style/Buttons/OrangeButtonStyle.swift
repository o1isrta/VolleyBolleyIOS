//
//  OrangeButtonStyle.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 13.08.2025.
//

import UIKit

struct OrangeButtonStyle {
    let backgroundColor: UIColor
    let titleColor: UIColor
    let font: UIFont
    let cornerRadius: CGFloat
    let contentInsets: NSDirectionalEdgeInsets

    init(
        backgroundColor: UIColor = AppColor.Background.buttonMap,
        titleColor: UIColor = AppColor.Text.inverted,
        font: UIFont = AppFont.Hero.regular(size: 16),
        cornerRadius: CGFloat = 16,
        contentInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(
            top: 14,
            leading: 16,
            bottom: 14,
            trailing: 16
        )
    ) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.font = font
        self.cornerRadius = cornerRadius
        self.contentInsets = contentInsets
    }
}

extension OrangeButtonStyle {

    static let small = OrangeButtonStyle(
        cornerRadius: 10,
        contentInsets: .init(top: 8, leading: 10, bottom: 8, trailing: 10)
    )

    static let large = OrangeButtonStyle()
}
