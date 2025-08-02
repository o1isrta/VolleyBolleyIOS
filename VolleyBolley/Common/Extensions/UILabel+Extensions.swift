//
//  UILabel+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 02.08.2025.
//

import UIKit

extension UILabel {
	func setTextWithDifferentStyles(_ texts: [(String, UIFont)]) {
		let attributedString = NSMutableAttributedString()

		for (text, font) in texts {
			let attributes: [NSAttributedString.Key: Any] = [
				.font: font
			]
			attributedString.append(NSAttributedString(string: text, attributes: attributes))
		}

		self.attributedText = attributedString
	}
}
