//
//  SketchButtonStyle.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.08.2025.
//

import UIKit

struct SketchButtonStyle {
	var backgroundColor: UIColor = .clear
	var titleColor: UIColor = AppColor.Text.primary
	var font: UIFont = AppFont.ActayWide.bold(size: 24)
	var cornerRadius: CGFloat = 32
	var tintColor: UIColor = AppColor.Icon.primary
	var glassAlpha: CGFloat = 0
}

enum SketchButtonStateStyle {

	case normal, selected, highlightedNormal, highlightedSelected

	var style: SketchButtonStyle {
		switch self {
		case .normal:
			return SketchButtonStyle(glassAlpha: 1)
		case .selected:
			return SketchButtonStyle(
				backgroundColor: AppColor.Background.buttonYellowSelected,
				titleColor: AppColor.Text.inverted
			)
		case .highlightedNormal:
			return SketchButtonStyle(glassAlpha: 0.7)
		case .highlightedSelected:
			return SketchButtonStyle(
				backgroundColor: AppColor.Background.buttonYellowSelected.withAlphaComponent(0.7),
				titleColor: AppColor.Text.inverted
			)
		}
	}
}
