//
//  CustomNoteView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

/// Represents the display style of the message input view.
enum CustomNoteViewType {
	/// Displays a character counter in the bottom-right corner.
	case withCounter
	/// Does not display a character counter.
	case noCounter
}

/// A custom `UIView` for entering a text message with optional character counting and placeholder support.
///
/// Features:
/// - Optional character counter (up to 160 characters).
/// - Placeholder label that appears when the text field is empty.
/// - Automatic placeholder visibility management.
/// - Text length enforcement (user cannot exceed 160 characters).
///
/// The view uses a `UITextView` internally for multi-line input and supports real-time text change callbacks.
///
/// ### Usage Example:
/// ```swift
/// // In your view controller:
/// let customNoteView = CustomNoteView(type: .withCounter)
/// messageInputView.translatesAutoresizingMaskIntoConstraints = false
/// view.addSubview(messageInputView)
///
/// NSLayoutConstraint.activate([
///     customNoteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
///     customNoteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
///     customNoteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
///     customNoteView.heightAnchor.constraint(equalToConstant: 120)
/// ])
///
/// // Observe real-time text changes
/// customNoteView.onTextChange = { [weak self] text in
///     print("Current message: \(text)")
///     // Example: Enable send button only if message is not empty
///     self?.sendButton.isEnabled = !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
/// }
/// ```
final class CustomNoteView: UIView {

	// MARK: - Public Properties

	/// A closure that is called whenever the text in the message field changes.
	/// Provides the current text as a `String`.
	///
	/// Set this property to receive real-time updates from the view.
	var onTextChange: ((String) -> Void)?

	// MARK: - Private Properties

	private let customNoteViewType: CustomNoteViewType
	private let maxMessageLength: Int

	private enum Constants {
		static let maxMessageLength: Int = 160

		static let inset: CGFloat = 8
		static let insetLarge: CGFloat = 16

		static let titleFontSize: CGFloat = 20
		static let messageFontSize: CGFloat = 16
		static let counterFontSize: CGFloat = 14
	}

	private lazy var messageContainerView: GlassmorphismView = GlassmorphismView(configuration: .message)

	private lazy var messageTextField: UITextView = {
		let textView = UITextView()
		textView.backgroundColor = AppColor.Background.clear
		textView.textColor = AppColor.Text.primary
		textView.font = AppFont.Hero.regular(size: Constants.messageFontSize)
		textView.textAlignment = .left
		return textView
	}()

	private lazy var messagePlaceholderLabel: UILabel = {
		let label = UILabel()
		label.text = String(localized: "messagePlaceholder")
		label.textColor = AppColor.Text.primary
		label.font = AppFont.Hero.light(size: Constants.messageFontSize)
		return label
	}()

	private lazy var messageLettersCounter: UILabel = {
		let counter = UILabel()
		counter.textColor = AppColor.Text.primary
		counter.font = AppFont.Hero.light(size: Constants.counterFontSize)
		counter.textAlignment = .right
		counter.text = "0/\(maxMessageLength)"
		counter.backgroundColor = AppColor.Background.clear
		return counter
	}()

	// MARK: - Initializers

	init(type: CustomNoteViewType, maxMessageLength: Int = Constants.maxMessageLength) {
		self.customNoteViewType = type
		self.maxMessageLength = maxMessageLength
		super.init(frame: .zero)
		setupUI()
		messageTextField.delegate = self
		setupCounter()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	override func layoutSubviews() {
		messageContainerView.resetForReuse()
		super.layoutSubviews()
	}
}

// MARK: - Private Properties

private extension CustomNoteView {

	func updateMessageCount(_ count: Int) {
		messageLettersCounter.text = "\(count)/\(maxMessageLength)"
	}

	func isPlaceholderVisible(_ show: Bool) {
		messagePlaceholderLabel.isHidden = show
	}

	func setupCounter() {
		guard customNoteViewType == .withCounter else { return }
		addSubviews(messageLettersCounter)
		NSLayoutConstraint.activate([
			messageLettersCounter.trailingAnchor.constraint(
				equalTo: messageContainerView.trailingAnchor,
				constant: -Constants.insetLarge
			),
			messageLettersCounter.bottomAnchor.constraint(
				equalTo: messageContainerView.bottomAnchor,
				constant: -Constants.insetLarge
			)
		])
	}

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		addSubviews(
			messageContainerView,
			messageTextField,
			messagePlaceholderLabel
		)
		NSLayoutConstraint.activate([
			messageContainerView.topAnchor.constraint(equalTo: topAnchor),
			messageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			messageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			messageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),

			messageTextField.topAnchor.constraint(
				equalTo: messageContainerView.topAnchor,
				constant: Constants.inset
			),
			messageTextField.leadingAnchor.constraint(
				equalTo: messageContainerView.leadingAnchor,
				constant: Constants.insetLarge
			),
			messageTextField.trailingAnchor.constraint(
				equalTo: messageContainerView.trailingAnchor,
				constant: -Constants.insetLarge
			),
			messageTextField.bottomAnchor.constraint(
				equalTo: messageContainerView.bottomAnchor,
				constant: -Constants.inset
			),

			messagePlaceholderLabel.topAnchor.constraint(
				equalTo: messageContainerView.topAnchor,
				constant: Constants.insetLarge
			),
			messagePlaceholderLabel.leadingAnchor.constraint(
				equalTo: messageContainerView.leadingAnchor,
				constant: Constants.insetLarge
			)
		])
	}
}

// MARK: - UITextViewDelegate

extension CustomNoteView: UITextViewDelegate {

	func textView(
		_ textView: UITextView,
		shouldChangeTextIn range: NSRange,
		replacementText text: String
	) -> Bool {
		let currentText = textView.text ?? ""
		guard let stringRange = Range(range, in: currentText) else { return false }
		let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
		return updatedText.count <= maxMessageLength
	}

	func textViewDidBeginEditing(_ textView: UITextView) {
		isPlaceholderVisible(true)
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		isPlaceholderVisible(!textView.text.isEmpty)
	}

	func textViewDidChange(_ textView: UITextView) {
		isPlaceholderVisible(!textView.text.isEmpty)

		guard
			customNoteViewType == .withCounter,
			let text = textView.text
		else { return }

		updateMessageCount(text.count)
		onTextChange?(text)
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	UIViewPreview {
		let view = CustomNoteView(type: .withCounter)
		return view
	}
	.frame(width: .infinity, height: 106)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()

	UIViewPreview {
		let view = CustomNoteView(type: .noCounter)
		return view
	}
	.frame(width: .infinity, height: 89)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
