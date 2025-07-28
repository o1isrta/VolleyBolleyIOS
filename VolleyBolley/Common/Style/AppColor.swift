//
//  AppColor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

/// Инкапсуляция уникальных цветов проекта: фирменные акценты, состояния и фоны
/// Только для однородных цветов (solid colors)
enum AppColor {

	enum Background {
		// main
		static let screen = darkTeal
		static let navBar = teal
		static let tabBar = midnightTeal
		static let modal = teal
		static let primary = white

		// buttons
		static let actionButtonDefault = yellow
		static let actionButtonDisabled = mistGrey
		static let largeActionButtonDefault = yellow
		static let mapButton = orange

		// badges
		static let badgeDefault = steelBlue
		static let badgeSelected = mutedTeal
		static let levelBadgeLight = blue
		static let levelBadgeMedium = green
		static let levelBadgeHard = orange
		static let levelBadgePro = yellow

		// pin
		static let pinDefault = mutedTeal
		static let pinSelected = orange

		static let searField = white

		static let calendar = white
	}

	enum Text {
		static let primary = white
		static let inverted = ashBrown
		static let placeHolder = grey
	}

	enum Icon {
		static let primary = white
		static let inverted = ashBrown
		static let location = orange
		static let star = orange
		static let searField = darkGrey
		static let avatar = tealBlue
	}

	enum Border {
		static let actionButton = yellow
		static let primary = white
		static let inverted = ashBrown
	}

	enum Calendar {
		static let primary = darkCharcoal
		static let secondary = lightGrey
		static let disabled = mistGrey
	}

	enum Gradient {
		static let greenLightStart = butterYellow
		static let greenLightEnd = mint
	}
}

/// Цвета по названиям
/// Только для переиспользования в AppColor
private extension AppColor {
	static let white = UIColor.white
	static let ashBrown = UIColor(hex: "#423F39")
	static let midnightTeal = UIColor(hex: "#295E6D")
	static let darkTeal = UIColor(hex: "#32716B")
	static let teal = UIColor(hex: "#53A8A1")
	static let tealBlue = UIColor(hex: "#438b97")
	static let blue = UIColor(hex: "#53A4E6")
	static let green = UIColor(hex: "#2DB69A")
	static let orange = UIColor(hex: "#E6AC53")
	static let yellow = UIColor(hex: "#E6C953")
	static let grey = UIColor(hex: "#7C7C7C")
	static let mistGrey = UIColor(hex: "#8CA5A3")
	static let darkGrey = UIColor(hex: "#484848")
	static let darkCharcoal = UIColor(hex: "#333333")
	static let lightGrey = UIColor(hex: "#E0E0E0")
	static let steelBlue = UIColor(hex: "#516372")
	static let mutedTeal = UIColor(hex: "#578D83")
	static let red = UIColor(hex: "#BA0000")
	static let butterYellow = UIColor(hex: "#F4E998")
	static let mint = UIColor(hex: "#5CF08D")
}
