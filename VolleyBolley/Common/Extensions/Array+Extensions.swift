//
//  Array+Extensions.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 19.10.2025.
//

import Foundation

extension Array where Element: Equatable {

	mutating func toggle(_ element: Element) {
		if let index = self.firstIndex(of: element) {
			self.remove(at: index)
		} else {
			self.append(element)
		}
	}
}
