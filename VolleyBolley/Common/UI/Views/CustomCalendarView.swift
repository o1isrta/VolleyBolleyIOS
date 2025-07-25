//
//  CustomCalendarView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 23.07.2025.
//

import UIKit

//class CustomCalendarViewController: UIViewController {
//
//	private let calendarView = UICalendarView()
//	private var gradientView: UIView?
//	private var currentSelection: DateComponents?
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		setupCalendar()
//		setupUI()
//	}
//
//	private func setupCalendar() {
//		// Настройка календаря
//		calendarView.calendar = Calendar(identifier: .gregorian)
//		calendarView.fontDesign = .monospaced
//		calendarView.layer.cornerRadius = 32
//		calendarView.clipsToBounds = true
//
//		// Настройка выделения даты
//		let dateSelection = UICalendarSelectionSingleDate(delegate: self)
//		calendarView.selectionBehavior = dateSelection
//
//		// Настройка внешнего вида
//		if let font = UIFont(name: "Hero-Regular", size: 16) {
////			calendarView.appearance().titleFont = font
////			calendarView.appearance().weekdayFont = font.withSize(14)
//		}
//
//		// Кастомизация отображения
////		calendarView.appearance().todayColor = .clear
////		calendarView.appearance().selectionColor = .clear
//	}
//
//	private func setupUI() {
//		view.backgroundColor = .systemBackground
//
//		// Добавление календаря
//		calendarView.translatesAutoresizingMaskIntoConstraints = false
//		view.addSubview(calendarView)
//
//		NSLayoutConstraint.activate([
//			calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//			calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//			calendarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
//			calendarView.heightAnchor.constraint(equalTo: calendarView.widthAnchor, multiplier: 1.1)
//		])
//	}
//
//	private func updateSelectedDateView(dateComponents: DateComponents?) {
//		// Удаляем предыдущий градиент
//		gradientView?.removeFromSuperview()
//
//		guard let dateComponents = dateComponents,
//			  let date = calendarView.calendar.date(from: dateComponents) else {
//			return
//		}
//
//		// Создаем градиентное view
//		let gradientView = UIView()
//		gradientView.layer.cornerRadius = 16
//		gradientView.clipsToBounds = true
//
//		// Настраиваем градиент
//		let gradientLayer = CALayer.getGradientLayer()
////		view.frame = bounds
//		gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
//		gradientLayer.cornerRadius = 16
//		gradientView.layer.insertSublayer(gradientLayer, at: 0)
//
//		// Добавляем к календарю
//		calendarView.addSubview(gradientView)
//		gradientView.translatesAutoresizingMaskIntoConstraints = false
//
//		// Рассчитываем позицию для выбранной даты
//		let dateFormatter = DateFormatter()
//		dateFormatter.dateFormat = "yyyy-MM-dd"
//		let dateString = dateFormatter.string(from: date)
//
//		// Это временное решение - в реальном приложении нужно точнее определять позицию
//		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//			if let cell = self.findDateCell(for: dateString) {
//				let cellFrame = cell.convert(cell.bounds, to: self.calendarView)
//				gradientView.center = CGPoint(x: cellFrame.midX, y: cellFrame.midY)
//				gradientView.frame.size = CGSize(width: 40, height: 40)
//			}
//		}
//
//		self.gradientView = gradientView
//		self.currentSelection = dateComponents
//	}
//
//	private func findDateCell(for dateString: String) -> UIView? {
//		// Рекурсивный поиск ячейки с нужной датой
//		func findView(in view: UIView) -> UIView? {
//			if let label = view as? UILabel,
//			   label.text == dateString.components(separatedBy: "-").last {
//				return view.superview
//			}
//
//			for subview in view.subviews {
//				if let found = findView(in: subview) {
//					return found
//				}
//			}
//			return nil
//		}
//
//		return findView(in: calendarView)
//	}
//}
//
//// MARK: - UICalendarSelectionDelegate
//extension CustomCalendarViewController: UICalendarSelectionSingleDateDelegate {
//	func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
//		updateSelectedDateView(dateComponents: dateComponents)
//	}
//}

import SwiftUI

struct CustomCalendarView: View {

	@Binding var selectedDate: Date
	let dateRange: ClosedRange<Date>?

	private var calendar = Calendar(identifier: .gregorian)
	@State private var currentDate = Date()
	@State private var selectedYear: Int = 0
	@State private var showingYearPicker = false

	init(selectedDate: Binding<Date>, dateRange: ClosedRange<Date>?) {
		self._selectedDate = selectedDate
		self.dateRange = dateRange
		self.calendar.firstWeekday = 2
	}

	var body: some View {
		VStack(spacing: 12) {
			// Header
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

			// Days of the week
			LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
				ForEach(weekdays, id: \.self) { day in
					Text(day)
						.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
						.foregroundColor(Color(AppColor.Calendar.primary))
						.frame(height: 28)
				}
			}

			// Calendar
			LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
				ForEach(daysInMonth, id: \.self) { date in
					dateButton(for: date)
				}
			}
		}
		.padding(.horizontal, 12)
		.padding(.vertical, 16)
		.sheet(isPresented: $showingYearPicker) {
			YearPickerView(
				selectedYear: $selectedYear,
				currentDate: $currentDate,
				showingYearPicker: $showingYearPicker
			)
			.clipShape(RoundedRectangle(cornerRadius: 32))
			.presentationDetents([.height(200)])
			.presentationCornerRadius(32)
		}
	}

	// MARK: - Private Properties

	private var isPastDate: Bool {
		calendar.isDate(Date(), equalTo: monthAnchor, toGranularity: .month)
	}

	private var monthAnchor: Date {
		calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)) ?? currentDate
	}

	private var monthYearString: String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
		formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
		return formatter.string(from: currentDate)
	}

	private var weekdays: [String] {
		var weekdayCalendar = calendar
		weekdayCalendar.firstWeekday = 2

		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
		formatter.setLocalizedDateFormatFromTemplate("EEE")
		// We get the beginning of the week from Monday
		let startOfWeek = weekdayCalendar.date(from: weekdayCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()

		return (0..<7).map { index in
			guard
				let date = weekdayCalendar.date(byAdding: .day, value: index, to: startOfWeek)
			else { return "" }
			return formatter.string(from: date).uppercased()
		}
	}

	private var startOfWeek: Date {
		var weekCalendar = calendar
		weekCalendar.firstWeekday = 2

		let components = weekCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthAnchor)
		return weekCalendar.date(from: components) ?? Date()
	}

	private var daysInMonth: [Date] {
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

	// MARK: - Private Methods

	private func isPastDate(_ date: Date) -> Bool {
		date <= Calendar.current.startOfDay(for: Date())
	}

	private func showYearPicker() {
		showingYearPicker = true
		selectedYear = calendar.component(.year, from: currentDate)
	}

	private func selectDateAction(date: Date, isCurrentMonth: Bool) {
		selectedDate = date
		// If a day is not selected from the current month, switch the calendar to this month
		if !isCurrentMonth {
			currentDate = date
		}
	}

	private func dateButton(for date: Date) -> some View {
		let isCurrentMonth = calendar.isDate(date, equalTo: monthAnchor, toGranularity: .month)
		let isSelected = isSameDay(selectedDate, date)
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

	private func backgroundView(
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

	private func getDayForegroundColor(
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

	private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
		calendar.isDate(date1, inSameDayAs: date2)
	}

	private func previousMonth() {
		withAnimation {
			currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
		}
	}

	private func nextMonth() {
		withAnimation {
			currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
		}
	}
}

// MARK: - YearPickerView

/// Year Selection Component
struct YearPickerView: View {

	@Binding var selectedYear: Int
	@Binding var currentDate: Date
	@Binding var showingYearPicker: Bool

	private let calendar = Calendar(identifier: .gregorian)
	private let currentYear = Calendar.current.component(.year, from: Date())
	private let yearsRange: [Int]

	init(selectedYear: Binding<Int>, currentDate: Binding<Date>, showingYearPicker: Binding<Bool>) {
		self._selectedYear = selectedYear
		self._currentDate = currentDate
		self._showingYearPicker = showingYearPicker
		// Create a range of years from current to current + 3
		let currentYear = Calendar.current.component(.year, from: Date())
		self.yearsRange = Array(currentYear...(currentYear + 3))
	}

	var body: some View {
		NavigationView {
			VStack {
				Picker("Select Year", selection: $selectedYear) {
					ForEach(yearsRange, id: \.self) { year in
						Text(year.description)
					}
				}
				.pickerStyle(WheelPickerStyle())
			}
			.navigationTitle("Select Year")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						showingYearPicker = false
					}
					.font(Font(AppFont.Hero.bold(size: 16) as CTFont))
				}

				ToolbarItem(placement: .confirmationAction) {
					Button("Done") {
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
		showingYearPicker = false
	}
}

// MARK: - Preview

struct CalendarViewExample: View {

	@State private var selectedDate = Date()

	private let dayCaption: String = "Выбранная дата:"

	var body: some View {
		VStack {
			CustomCalendarView(selectedDate: $selectedDate, dateRange: nil)
				.background(
					RoundedRectangle(cornerRadius: 32)
						.fill(Color(AppColor.Background.calendar))
				)

			Text("\(dayCaption) \(selectedDate.formatted(date: .complete, time: .omitted))")
				.font(Font(AppFont.Hero.regular(size: 16) as CTFont))
		}
		.padding()
	}
}

#Preview {
	ZStack {
		Color(AppColor.Background.screen).ignoresSafeArea()
		CalendarViewExample()
	}
}

// MARK: - Preview
//#if DEBUG
//
//@available(iOS 17.0, *)
//#Preview {
//	CustomCalendarViewController()
//}
//#endif
