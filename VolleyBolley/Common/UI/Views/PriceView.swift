//
//  PriceView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 23.08.2025.
//

import UIKit

final class PriceView: UIView {

	// MARK: - Public Properties

	var onTextChanged: ((String?) -> Void)?

	var text: String? {
		get { return textField.text }
		set {
			guard let text = newValue else { return }
			let filtered = text.filter { "0123456789".contains($0) }
			textField.text = String(filtered)
			onTextChanged?(textField.text)
		}
	}

	// MARK: - Private Properties

	private let cornerRadius: CGFloat = 16
	private let maxCharacterCount = 5

	private lazy var gradientBorderLayer: CAGradientLayer = CAGradientLayer.getGradientLayer()

	private lazy var maskLayer: CAShapeLayer = {
		let maskLayer = CAShapeLayer()
		maskLayer.lineWidth = 2
		maskLayer.strokeColor = AppColor.Border.primary.cgColor
		maskLayer.fillColor = UIColor.clear.cgColor
		return maskLayer
	}()

	private let containerView = GlassmorphismView(configuration: .price)

	private lazy var textField: UITextField = {
		let textField = UITextField()
		textField.delegate = self
		textField.attributedPlaceholder = NSAttributedString(
			string: "0",
			attributes: [
				.foregroundColor: AppColor.Text.primary.withAlphaComponent(0.5)
			]
		)
		textField.keyboardType = .numbersAndPunctuation
		textField.font = AppFont.Hero.regular(size: 16)
		textField.textColor = AppColor.Text.primary
		textField.textAlignment = .center
		textField.borderStyle = .none
		textField.backgroundColor = .clear
		return textField
	}()

	private lazy var dollarLabel: CustomLabel = {
		let label = CustomLabel(text: "$")
		label.textAlignment = .center
		return label
	}()

	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [textField, dollarLabel])
		stack.axis = .horizontal
		stack.alignment = .center
		stack.distribution = .fill
		return stack
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupGesture()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	override func layoutSubviews() {
		super.layoutSubviews()
		containerView.resetForReuse()
	}

	// MARK: - Public Methods

	func becomeActive() {
		textField.becomeFirstResponder()
	}

	func getNumericValue() -> Double? {
		guard let text = textField.text, !text.isEmpty else {
			return nil
		}
		return Double(text)
	}
}

// MARK: - Private Methods

private extension PriceView {

	func setupGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		containerView.addGestureRecognizer(tapGesture)
	}

	func setupUI() {
		addSubviews(containerView)
		containerView.addSubviews(stackView)

		NSLayoutConstraint.activate([
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			containerView.topAnchor.constraint(equalTo: topAnchor),
			containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

			stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			stackView.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 6),
			stackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -6)
		])

		dollarLabel.setContentHuggingPriority(.required, for: .horizontal)
		textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
	}

	@objc func handleTap() {
		becomeActive()
	}
}

// MARK: - UITextFieldDelegate

extension PriceView: UITextFieldDelegate {

	func textFieldDidChangeSelection(_ textField: UITextField) {
		onTextChanged?(textField.text)
	}

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		if string.isEmpty { return true }
		// We check that only numbers are entered
		let allowedCharacters = CharacterSet.decimalDigits
		let characterSet = CharacterSet(charactersIn: string)
		guard allowedCharacters.isSuperset(of: characterSet) else {
			return false
		}
		let currentText = textField.text ?? ""
		// Calculate new text after change
		guard let stringRange = Range(range, in: currentText) else {
			return false
		}
		let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
		return updatedText.count <= maxCharacterCount
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		animateGradientBorder(show: true)
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		animateGradientBorder(show: false)
	}

	private func animateGradientBorder(show: Bool) {
		gradientBorderLayer.removeFromSuperlayer()

		guard show else { return }

		let borderWidth: CGFloat = 1.5
		let borderBounds = CGRect(
			x: 0,
			y: 0,
			width: containerView.bounds.width,
			height: containerView.bounds.height
		)
		gradientBorderLayer.frame = borderBounds
		// Create path for border
		let borderPath = UIBezierPath(
			roundedRect: borderBounds.insetBy(dx: borderWidth/2, dy: borderWidth/2),
			byRoundingCorners: .allCorners,
			cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
		)
		// Create mask for gradient
		maskLayer.path = borderPath.cgPath
		gradientBorderLayer.mask = maskLayer
		layer.insertSublayer(gradientBorderLayer, at: 3)
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
class ViewController: BaseViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let customTextField = PriceView(frame: CGRect(x: 50, y: 150, width: 75, height: 30))
		customTextField.text = "$100.00"
		view.addSubview(customTextField)

		let customTextField2 = PriceView(frame: CGRect(x: 50, y: 200, width: 75, height: 30))
		view.addSubview(customTextField2)
	}
}

@available(iOS 17.0, *)
#Preview {
	ViewController()
}
#endif
