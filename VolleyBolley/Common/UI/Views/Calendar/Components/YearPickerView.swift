//
//  YearPickerView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.07.2025.
//

import SwiftUI

/// Year Selection Component
struct YearPickerView: View {

	// MARK: - Public Properties

	@Binding var selectedYear: Int
	@Binding var currentDate: Date

	// MARK: - Private Properties

	@Environment(\.dismiss) private var dismiss

	private let calendar = Calendar(identifier: .gregorian)
	private let currentYear = Calendar.current.component(.year, from: Date())
	private let yearsRange: [Int]

	// MARK: - Initializers

	init(selectedYear: Binding<Int>, currentDate: Binding<Date>) {
		self._selectedYear = selectedYear
		self._currentDate = currentDate
		// Create a range of years from current to current + 3
		let currentYear = Calendar.current.component(.year, from: Date())
		self.yearsRange = Array(currentYear...(currentYear + 3))
	}

	var body: some View {
		NavigationView {
			VStack {
				Picker("yearPicker.selectYear", selection: $selectedYear) {
					ForEach(yearsRange, id: \.self) { year in
						Text(year.description)
					}
				}
				.pickerStyle(WheelPickerStyle())
			}
			.navigationTitle("yearPicker.selectYear")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("common.cancel") {
						dismiss()
					}
					.font(Font(AppFont.Hero.bold(size: 16) as CTFont))
				}

				ToolbarItem(placement: .confirmationAction) {
                    Button("common.done") {
                        updateCurrentDate()
                    }
					.font(Font(AppFont.Hero.bold(size: 16) as CTFont))
				}
			}
		}
	}
}

// MARK: - Private Methods

private extension YearPickerView {

	func updateCurrentDate() {
		// Update currentDate with new year
		var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
		components.year = selectedYear
		if let newDate = calendar.date(from: components) {
			currentDate = newDate
		}
		dismiss()
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	@Previewable @State var currentDate = Date()
	@Previewable @State var selectedYear: Int = 0

	ZStack {
		Color(AppColor.Background.screen).ignoresSafeArea()
		YearPickerView(selectedYear: $selectedYear, currentDate: $currentDate)
	}
}
#endif
