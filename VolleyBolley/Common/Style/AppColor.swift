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

        // button
        static let buttonPrimaryNormal = clear
        static let buttonPrimarySelected = yellow
        static let buttonPrimaryDisabled = mistGrey
        static let buttonAuthGoogle = white
        static let buttonAuthFacebook = facebookBlue
        static let buttonMap = orange
        static let buttonActionNormal = clear
        static let buttonActionSelected = yellow

        // badge
        static let badgeDefault = steelBlue
        static let badgeSelected = mutedTeal

        // level
        static let levelBadgeLight = blue
        static let levelBadgeMedium = green
        static let levelBadgeHard = orange
        static let levelBadgePro = yellow

		// pin
		static let pinDefault = mutedTeal
		static let pinSelected = orange

        static let searField = white
        static let calendar = white

        // alert
        static let alert = gray
    }

	enum Text {
		static let primary = white
		static let inverted = ashBrown
		static let placeHolder = gray
	}

    enum Border {
        static let buttonAction = yellow
        static let primary = white
        static let inverted = ashBrown
        static let separator = separatorGray
    }

	enum Icon {
		static let primary = white
		static let inverted = ashBrown
		static let location = orange
		static let star = orange
		static let searField = darkGray
		static let avatar = tealBlue
	}

	enum Calendar {
		static let primary = darkCharcoal
		static let secondary = lightGray
		static let disabled = mistGrey
	}

	enum Gradient {
		static let greenLightStart = butterYellow
		static let greenLightEnd = mint
	}

    enum Glassmorphism {
        static let border = white
        static let tintColor = white
        static let innerShadowColor = white
        static let outerShadowColor = darkCharcoal
    }
}

/// Цвета по названиям
/// Только для переиспользования в AppColor
private extension AppColor {

    static let clear = UIColor.clear
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
    static let mistGrey = UIColor(hex: "#8CA5A3")
    static let darkGray = UIColor(hex: "#484848")
    static let gray = UIColor(hex: "#7C7C7C")
    static let lightGray = UIColor(hex: "#E0E0E0")
    static let separatorGray = UIColor(hex: "#C3C3C3")
    static let steelBlue = UIColor(hex: "#516372")
    static let mutedTeal = UIColor(hex: "#578D83")
    static let red = UIColor(hex: "#BA0000")
    static let butterYellow = UIColor(hex: "#F4E998")
    static let mint = UIColor(hex: "#5CF08D")
    static let facebookBlue = UIColor(hex: "#1877F2")
	static let darkCharcoal = UIColor(hex: "#333333")
    static let grayBackground = UIColor(hex: "#555252")
}
