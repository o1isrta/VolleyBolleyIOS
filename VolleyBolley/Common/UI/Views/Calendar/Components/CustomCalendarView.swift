//
//  CustomCalendarView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.07.2025.
//

import SwiftUI

struct CustomCalendarView: View {

	// MARK: - Public Properties

	@ObservedObject var viewModel: CalendarViewModel

	// MARK: - Private Properties

	@State private var currentDate = Date()
	@State private var selectedYear: Int = 0
	@State private var showingYearPicker = false

	private var calendar = Calendar(identifier: .gregorian)

	// MARK: - Initializers

	init(viewModel: CalendarViewModel) {
		self.viewModel = viewModel
		self.calendar.firstWeekday = 2
	}

	var body: some View {
		VStack(spacing: 12) {
			monthView
			weekView
			calendarView
		}
		.padding(.horizontal, 12)
		.padding(.vertical, 16)
		.sheet(isPresented: $showingYearPicker) {
			YearPickerView(
				selectedYear: $selectedYear,
				currentDate: $currentDate
			)
			.clipShape(RoundedRectangle(cornerRadius: 32))
			.presentationDetents([.height(200)])
			.presentationCornerRadius(32)
		}
	}
}

// MARK: - Subviews

private extension CustomCalendarView {

	var monthView: some View {
		HStack {
			Button(action: previousMonth) {
				Image(systemName: "chevron.left")
					.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
					.foregroundColor(.primary)
			}
			.disabled(isPastDate)

			Spacer()

			Button(action: showYearPicker) {
				Text(monthYearString.replacingOccurrences(of: " ", with: ", "))
					.font(Font(AppFont.ActayWide.bold(size: 16) as CTFont))
					.foregroundColor(Color(AppColor.Calendar.primary))
				Image(systemName: "chevron.down")
					.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
					.foregroundColor(Color(AppColor.Calendar.primary))
			}

			Spacer()

			Button(action: nextMonth) {
				Image(systemName: "chevron.right")
					.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
					.foregroundColor(Color(AppColor.Calendar.primary))
			}
		}
		.frame(height: 21)
		.padding(.horizontal, 12)
	}

	var weekView: some View {
		LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
			ForEach(weekdays, id: \.self) { day in
				Text(day.capitalized)
					.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
					.foregroundColor(Color(AppColor.Calendar.primary))
					.frame(height: 28)
			}
		}
	}

	var calendarView: some View {
		LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
			ForEach(daysInMonth, id: \.self) { date in
				dateButton(for: date)
			}
		}
	}
}

// MARK: - Сalculated Properties

private extension CustomCalendarView {

	var isPastDate: Bool {
		calendar.isDate(Date(), equalTo: monthAnchor, toGranularity: .month)
	}

	var monthAnchor: Date {
		calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)) ?? currentDate
	}

	var monthYearString: String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
		formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
		return formatter.string(from: currentDate)
	}

	var weekdays: [String] {
		var weekdayCalendar = calendar
		weekdayCalendar.firstWeekday = 2

		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
		formatter.setLocalizedDateFormatFromTemplate("EEE")
		// We get the beginning of the week from Monday
		let startOfWeek = weekdayCalendar.date(
			from: weekdayCalendar.dateComponents(
				[.yearForWeekOfYear, .weekOfYear],
				from: Date()
			)
		) ?? Date()

		return (0..<7).map { index in
			guard
				let date = weekdayCalendar.date(byAdding: .day, value: index, to: startOfWeek)
			else { return "" }
			return formatter.string(from: date).uppercased()
		}
	}

	var startOfWeek: Date {
		var weekCalendar = calendar
		weekCalendar.firstWeekday = 2

		let components = weekCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthAnchor)
		return weekCalendar.date(from: components) ?? Date()
	}

	var daysInMonth: [Date] {
		guard let monthInterval = calendar.dateInterval(of: .month, for: monthAnchor) else {
			return []
		}

		let startComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthInterval.start)
		guard
			let startDate = calendar.date(from: startComponents),
			let endDate = calendar.date(byAdding: .day, value: 41, to: startDate)
		else {
			return []
		}

		var days: [Date] = []
		var date = startDate

		while date <= endDate {
			days.append(date)
			date = calendar.date(byAdding: .day, value: 1, to: date) ?? startDate
		}

		return days
	}
}

// MARK: - Private Methods

private extension CustomCalendarView {

	func isPastDate(_ date: Date) -> Bool {
		date < Calendar.current.startOfDay(for: Date())
	}

	func showYearPicker() {
		showingYearPicker = true
		selectedYear = calendar.component(.year, from: currentDate)
	}

	func selectDateAction(date: Date, isCurrentMonth: Bool) {
		viewModel.updateSelectedDate(date)
		// If a day is not selected from the current month, switch the calendar to this month
		if !isCurrentMonth {
			currentDate = date
		}
	}

	func dateButton(for date: Date) -> some View {
		let isCurrentMonth = calendar.isDate(date, equalTo: monthAnchor, toGranularity: .month)
		let isSelected = isSameDay(viewModel.selectedDate, date)
		let isPastDate = isPastDate(date)
		let isToday = calendar.isDateInToday(date)

		// swiftlint:disable multiple_closures_with_trailing_closure
		return Button(action: {
			if !isPastDate {
				selectDateAction(date: date, isCurrentMonth: isCurrentMonth)
			}
		}) {
			Text("\(calendar.component(.day, from: date))")
				.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
				.foregroundColor(
					getDayForegroundColor(
						isSelected: isSelected,
						isCurrentMonth: isCurrentMonth,
						isPastDate: isPastDate
					)
				)
				.frame(width: 32, height: 32)
				.background(
					backgroundView(
						isSelected: isSelected,
						isToday: isToday,
						isCurrentMonth: isCurrentMonth,
						isPastDate: isPastDate
					)
				)
		}
		.disabled(isPastDate)
		// swiftlint:enable multiple_closures_with_trailing_closure
	}

	func backgroundView(
		isSelected: Bool,
		isToday: Bool,
		isCurrentMonth: Bool,
		isPastDate: Bool
	) -> some View {
		Group {
			if isSelected {
				RoundedRectangle(cornerRadius: 16)
					.fill(
						LinearGradient(
							gradient: Gradient(colors: AppGradient.greenLight.map {Color($0)}),
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						)
					)
					.frame(width: 42, height: 32)
			} else if isToday && isCurrentMonth && !isPastDate {
				RoundedRectangle(cornerRadius: 16)
					.stroke(Color(AppColor.Calendar.primary), lineWidth: 1)
					.frame(width: 42, height: 32)
			}
		}
	}

	func getDayForegroundColor(
		isSelected: Bool,
		isCurrentMonth: Bool,
		isPastDate: Bool = false
	) -> Color {
		if isPastDate && isCurrentMonth {
			return Color(AppColor.Calendar.disabled)
		}

		if isSelected || isCurrentMonth {
			return Color(AppColor.Calendar.primary)
		}

		return Color(AppColor.Calendar.secondary)
	}

	func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
		calendar.isDate(date1, inSameDayAs: date2)
	}

	func previousMonth() {
		withAnimation {
			currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
		}
	}

	func nextMonth() {
		withAnimation {
			currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
		}
	}
}

// MARK: - Preview

#if DEBUG
struct CalendarViewExample: View {

	@ObservedObject var viewModel = CalendarViewModel()

	private let dayCaption: String = "Выбранная дата:"

	var body: some View {
		VStack {
			CustomCalendarView(viewModel: viewModel)
				.background(
					RoundedRectangle(cornerRadius: 32)
						.fill(Color(AppColor.Background.calendar))
				)

			Text("\(dayCaption) \(viewModel.selectedDate.formatted(date: .complete, time: .omitted))")
				.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
		}
		.padding()
	}
}

@available(iOS 17.0, *)
#Preview {
	ZStack {
		Color(AppColor.Background.screen).ignoresSafeArea()
		CalendarViewExample()
	}
}
#endif
