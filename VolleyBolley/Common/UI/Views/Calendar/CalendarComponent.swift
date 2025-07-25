//
//  CalendarComponent.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.07.2025.
//

import Combine
import SwiftUI

/// Protocol for receiving date selection events from CalendarComponent
protocol CalendarComponentDelegate: AnyObject {
	
	/// Called when the user selects a new date in the calendar
	/// - Parameter date: The newly selected date
	///
	/// ## Example Implementation
	/// ```swift
	/// func didSelectDate(_ date: Date) {
	///     let formatter = DateFormatter()
	///     formatter.dateStyle = .medium
	///     dateLabel.text = formatter.string(from: date)
	/// }
	/// ```
	func didSelectDate(_ date: Date)
}

/// Protocol defining the public interface for CalendarComponent
///
/// This protocol allows for mocking and testing components that depend on CalendarComponent.
///
/// ## Example Usage
/// ```swift
/// class DateSelectionService {
///     private let calendar: CalendarComponentProtocol
///
///     init(calendar: CalendarComponentProtocol) {
///         self.calendar = calendar
///     }
///
///     func getCurrentSelection() -> Date {
///         return calendar.getSelectedDate()
///     }
/// }
/// ```
protocol CalendarComponentProtocol: AnyObject {
	
	/// The delegate that receives date selection events
	var delegate: CalendarComponentDelegate? { get set }
	
	/// Creates a view controller containing the calendar view
	/// - Returns: A UIViewController that can be added to your view hierarchy
	func createCalendarViewController() -> UIViewController
	
	/// Sets the currently selected date in the calendar
	/// - Parameter date: The date to select
	func setSelectedDate(_ date: Date)
	
	/// Gets the currently selected date from the calendar
	/// - Returns: The currently selected date
	func getSelectedDate() -> Date
}

/// A reusable calendar component that bridges SwiftUI's DatePicker to UIKit
///
/// ## Overview
/// `CalendarComponent` provides an easy way to integrate a SwiftUI calendar into UIKit views.
/// It handles all the SwiftUI/UIKit interoperability and provides a clean delegate-based interface.
///
/// ## Basic Usage
/// ```swift
/// // 1. Conform to CalendarComponentDelegate
/// class MyViewController: UIViewController, CalendarComponentDelegate {
///
///     // 2. Create an instance
///     private lazy var calendarComponent: CalendarComponentProtocol = CalendarComponent(delegate: self)
///
///     override func viewDidLoad() {
///         super.viewDidLoad()
///
///         // 3. Add calendar to view hierarchy
///         let calendarVC = calendarComponent.createCalendarViewController()
///         addChild(calendarVC)
///         view.addSubview(calendarVC.view)
///         // Set up constraints...
///         calendarVC.didMove(toParent: self)
///     }
///
///     // 4. Implement delegate method
///     func didSelectDate(_ date: Date) {
///         print("Selected date:", date)
///     }
/// }
/// ```
///
/// ## Setting and Getting Dates
/// ```swift
/// // Programmatically set date
/// calendarComponent.setSelectedDate(Date())
///
/// // Get current selected date
/// let currentDate = calendarComponent.getSelectedDate()
/// ```
final class CalendarComponent: CalendarComponentProtocol {
	
	// MARK: - Public Properties
	
	/// The delegate that receives date selection events
	weak var delegate: CalendarComponentDelegate?
	
	// MARK: - Private Properties
	
	private let viewModel = CalendarViewModel()
	private var hostingController: UIHostingController<CustomCalendarView>?
	private var cancellables = Set<AnyCancellable>()
	
	// MARK: - Initializers
	
	/// Initializes a new calendar component
	/// - Parameter delegate: The object that will receive date selection events
	init(delegate: CalendarComponentDelegate) {
		self.delegate = delegate
		setupBindings()
	}
	
	// MARK: - Public Methods
	
	/// Creates a view controller containing the calendar view
	/// - Returns: A UIViewController that can be added to your view hierarchy
	///
	/// ## Example
	/// ```swift
	/// let calendarVC = calendarComponent.createCalendarViewController()
	/// addChild(calendarVC)
	/// view.addSubview(calendarVC.view)
	/// // Configure constraints...
	/// calendarVC.didMove(toParent: self)
	/// ```
	func createCalendarViewController() -> UIViewController {
		let calendarView = CustomCalendarView(viewModel: viewModel)
		let hostingController = UIHostingController(rootView: calendarView)
		self.hostingController = hostingController
		
		configureAppearance(for: hostingController.view)
		return hostingController
	}
	
	/// Sets the currently selected date in the calendar
	/// - Parameter date: The date to select
	func setSelectedDate(_ date: Date) {
		viewModel.updateSelectedDate(date)
	}
	
	/// Gets the currently selected date from the calendar
	/// - Returns: The currently selected date
	func getSelectedDate() -> Date {
		return viewModel.selectedDate
	}
	
	// MARK: - Private Methods
	
	private func setupBindings() {
		viewModel.$selectedDate
			.sink { [weak self] date in
				self?.delegate?.didSelectDate(date)
			}
			.store(in: &cancellables)
	}
	
	private func configureAppearance(for view: UIView) {
		view.layer.cornerRadius = 32
		view.clipsToBounds = true
	}
}
