//
//  CalendarViewModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.07.2025.
//

import SwiftUI

final class CalendarViewModel: ObservableObject {

	// MARK: - Public Properties

	@Published var selectedDate: Date = Date()

	// MARK: - Public Methods

	func updateSelectedDate(_ date: Date) {
		selectedDate = date
	}
}
