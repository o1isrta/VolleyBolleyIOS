//
//  CalendarViewModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.07.2025.
//

import SwiftUI

final class CalendarViewModel: ObservableObject {
	@Published var selectedDate: Date = Date()

	func updateSelectedDate(_ date: Date) {
		selectedDate = date
	}
}
