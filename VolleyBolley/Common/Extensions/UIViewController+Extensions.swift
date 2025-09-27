//
//  UIViewController+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 27.09.2025.
//

import UIKit

extension UIViewController {

	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc private func dismissKeyboard() {
		view.endEditing(true)
	}
}
