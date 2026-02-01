//
//  PaymentView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.02.2026.
//

import UIKit

final class PaymentView: UIView {

	// MARK: - Public Properties

	override var intrinsicContentSize: CGSize {
		return CGSize(
			width: UIView.noIntrinsicMetric,
			height: Constants.intrinsicContentHeight
		)
	}

	// MARK: - Private Properties

	private	let priceChanged: (String?) -> Void
	private	let addPaymentButtonAction: () -> Void

	private	enum Constants {
		static let intrinsicContentHeight: CGFloat = 114

		static let priceViewHeight: CGFloat = 30
		static let priceViewWidth: CGFloat = 75

		static let amountStackHeight: CGFloat = 52

		static let stackSpacing: CGFloat = 9
		static let stackLayoutMargins: UIEdgeInsets =  .init(
			top: 12,
			left: 0,
			bottom: 0,
			right: 0
		)

		static let fontSize: CGFloat = 16
	}

	private let paymentTitle = CustomTitle(
		text: String(localized: "payment.title"),
		isLarge: true
	)

	private let paymentDescription = CustomLabel(
		text: String(localized: "payment.description")
	)

	private let paymentPerPerson = CustomLabel(
		text: String(localized: "payment.perPerson") + ":",
		isBold: true
	)

	private lazy var priceView: PriceView = {
		let priceView = PriceView()
		priceView.isUserInteractionEnabled = false
		priceView.onTextChanged = { [weak self] price in
			self?.priceChanged(price)
		}
		return priceView
	}()

	private lazy var paymentPerPersonStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			paymentPerPerson,
			priceView
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .center
		stack.spacing = Constants.stackSpacing
		stack.layoutMargins = Constants.stackLayoutMargins
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private let currentAccountLabel: UILabel = {
		let label = UILabel()
		label.text = String(localized: "payment.currentAccountTitle")
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		label.textColor = AppColor.Text.primary
		return label
	}()

	private lazy var accountLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		label.textColor = AppColor.Text.primary
		label.isHidden = true
		return label
	}()

	private lazy var addPaymentButton: GreenButton = {
		let button = GreenButton()
		button.isSelected = false
		button.setTitle(String(localized: "payment.addPaymentButton"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.addPaymentButtonAction()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var amountStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			currentAccountLabel,
			accountLabel,
			addPaymentButton
		])
		stack.axis = .horizontal
		stack.distribution = .equalSpacing
		stack.alignment = .center
		stack.layoutMargins = Constants.stackLayoutMargins
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private lazy var paymentStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			paymentTitle,
			paymentDescription,
			paymentPerPersonStackView,
			amountStackView
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .leading
		return stack
	}()

	// MARK: - Initializers

	init(
		priceChanged: @escaping (String?) -> Void,
		addPaymentButtonAction: @escaping () -> Void
	) {
		self.priceChanged = priceChanged
		self.addPaymentButtonAction = addPaymentButtonAction
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func setAccountNumber(to number: String) {
		guard !number.isEmpty else { return }
		accountLabel.text = number
		updatePaymentState()
	}
}

// MARK: - Private Methods

private extension PaymentView {

	func updatePaymentState() {
		addPaymentButton.isHidden = true
		accountLabel.isHidden = false

		paymentDescription.text = String(localized: "payment.requirementDescription")

		priceView.isUserInteractionEnabled = true
		priceView.becomeActive()
	}

	func setupUI() {
		addSubviews(paymentStackView)
		paymentStackView.pinToSuperviewEdges()

		NSLayoutConstraint.activate([
			amountStackView.leadingAnchor.constraint(equalTo: paymentStackView.leadingAnchor),
			amountStackView.trailingAnchor.constraint(equalTo: paymentStackView.trailingAnchor),
			amountStackView.heightAnchor.constraint(equalToConstant: Constants.amountStackHeight),

			priceView.heightAnchor.constraint(equalToConstant: Constants.priceViewHeight),
			priceView.widthAnchor.constraint(equalToConstant: Constants.priceViewWidth)
		])
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI
@available(iOS 17.0, *)
#Preview {
	let height: CGFloat = 114

	VStack {
		UIViewPreview {
			lazy var paymentView = PaymentView(
				priceChanged: { price in
					print("Price changed: \(String(describing: price))")
				},
				addPaymentButtonAction: {
					print("addPaymentButtonTapped")
				}
			)
			return paymentView
		}
		.frame(height: height)

		Divider()
			.background(.white)
			.padding(.vertical)

		UIViewPreview {
			lazy var paymentView = PaymentView(
				priceChanged: { price in
					print("Price changed: \(String(describing: price))")
				},
				addPaymentButtonAction: {
					print("addPaymentButtonTapped")
				}
			)
			paymentView.setAccountNumber(to: "123 456 789")
			return paymentView
		}
		.frame(height: height)
	}
	.padding()
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
