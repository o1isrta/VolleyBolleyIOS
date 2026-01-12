//
//  TimePickerButton.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 05.08.2025.
//

import UIKit

/// A button for selecting and displaying time.
/// Displays time in "hours:minutes AM/PM" format.
final class TimePickerButton: UIButton {

	// MARK: - Constants

	private enum Constants {
		static let cornerRadius: CGFloat = 16
		static let stackSpacing: CGFloat = 4
		static let fontSize: CGFloat = 16
	}

	// MARK: - Public Properties

	/// The intrinsic content size of the button for automatic layout.
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 89, height: 49)
	}

	/// A closure that is called whenever the selected time changes.
	var onTimeChange: ((Date?) -> Void)?

	// MARK: - Private Properties

	/// A label displaying the time in "hours:minutes" format.
	private lazy var timeLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColor.Text.primary
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		label.isUserInteractionEnabled = false
		return label
	}()

	/// A label displaying the time period ("AM"/"PM").
	private lazy var periodLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColor.Text.primary
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		label.isUserInteractionEnabled = false
		return label
	}()

	/// A horizontal stack view that arranges the time and period labels.
	private lazy var labelStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [timeLabel, periodLabel])
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = Constants.stackSpacing
		stack.isUserInteractionEnabled = false
		return stack
	}()

	/// A background view with a glassmorphism effect.
	private let glassView: GlassmorphismView = {
		let view = GlassmorphismView(configuration: .timePicker)
		view.isUserInteractionEnabled = false
		return view
	}()

	/// The currently selected time.
	///
	/// When this value changes, `timeLabel` and `periodLabel` are automatically updated.
	/// May be `nil` if the user hasn't selected a time yet.
	///
	/// Whenever the value changes, the `onTimeChange` closure is invoked (if set),
	/// allowing external observers to react to time updates.
	private(set) var time: Date? {
		didSet {
			updateLabel()
			onTimeChange?(time)
		}
	}

	// MARK: - Initializers

	/// Initializes the time picker button.
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
		updateLabel()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }
}

// MARK: - Private Methods

private extension TimePickerButton {

	/// Configures the view hierarchy and constraints.
	func setup() {
		layer.cornerRadius = Constants.cornerRadius
		clipsToBounds = true

		addSubviews(glassView, labelStack)
		sendSubviewToBack(glassView)

		NSLayoutConstraint.activate([
			glassView.topAnchor.constraint(equalTo: topAnchor),
			glassView.bottomAnchor.constraint(equalTo: bottomAnchor),
			glassView.leadingAnchor.constraint(equalTo: leadingAnchor),
			glassView.trailingAnchor.constraint(equalTo: trailingAnchor),
			labelStack.centerXAnchor.constraint(equalTo: centerXAnchor),
			labelStack.centerYAnchor.constraint(equalTo: centerYAnchor)
		])

		addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}

	/// Updates the text of `timeLabel` and `periodLabel` based on the current time.
	///
	/// If `time` is `nil`, displays a placeholder "_:__ PM".
	func updateLabel() {
		guard let time else {
			timeLabel.text = "_:__"
			periodLabel.text = "PM"
			return
		}

		let fullTime = AppDateFormatters.time12Hour.string(from: time)
		let components = fullTime.components(separatedBy: " ")
		timeLabel.text = components.first ?? "_:__"
		periodLabel.text = components.last ?? "PM"
	}

	/// Handles button tap and presents a `UIDatePicker`.
	@objc private func buttonTapped() {
		showTimePicker()
	}

	/// Presents an alert with a system `UIDatePicker` for time selection.
	func showTimePicker() {
		guard let topController = topMostController() else { return }

		let alert = setupAlert()
		topController.present(alert, animated: true)
	}

	/// Creates and configures an alert containing a system `UIDatePicker` in time mode.
	///
	/// The alert includes "Cancel" and "OK" actions. Upon confirmation, the selected time
	/// is stored in the `time` property.
	///
	/// - Returns: A configured `UIAlertController` with an embedded `UIDatePicker`.
	func setupAlert() -> UIAlertController {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .time
		datePicker.preferredDatePickerStyle = .wheels
		datePicker.locale = AppConstants.AppLocale.posix
		datePicker.date = time ?? Date()

		alert.view.addSubviews(datePicker)

		NSLayoutConstraint.activate([
			datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 8),
			datePicker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 8),
			datePicker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -8),
			datePicker.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -44)
		])

		alert.addAction(UIAlertAction(
			title: String(localized: "customAlertView.button.cancel"),
			style: .cancel
		))

		alert.addAction(UIAlertAction(
			title: String(localized: "customAlertView.button.ok"),
			style: .default,
			handler: { [weak self] _ in
				self?.time = datePicker.date
			}
		))

		return alert
	}

	/// Returns the topmost view controller in the current window scene.
	func topMostController() -> UIViewController? {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
			  let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
			  var topController = keyWindow.rootViewController else {
			return nil
		}

		while let presentedViewController = topController.presentedViewController {
			topController = presentedViewController
		}
		return topController
	}

}

#if DEBUG

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	ZStack {
		Color(uiColor: AppColor.Background.screen)
			.ignoresSafeArea()
		UIViewPreview {
			TimePickerButton()
		}
		.frame(width: 89, height: 49)
	}
}
#endif
