//
//  CounterWithTitleView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 30.01.2026.
//

import UIKit

final class CounterWithTitleView: UIView {

	// MARK: - Public Properties

	var value: Int { counter.value }

	override var intrinsicContentSize: CGSize {
		return CGSize(
			width: UIView.noIntrinsicMetric,
			height: Constants.intrinsicContentHeight
		)
	}

	// MARK: - Private Properties

	private var type: CounterType

	private	enum Constants {
		static let intrinsicContentHeight: CGFloat = 75
		static let counterHeight: CGFloat = 39

		static let stackSpacing: CGFloat = 12
	}

	private lazy var title = CustomTitle(
		text: type.title,
		isLarge: true
	)

	private lazy var counter = CounterView(type: type)

	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			title,
			counter
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .leading
		stack.spacing = Constants.stackSpacing
		return stack
	}()

	// MARK: - Initializers

	init(type: CounterType, valueChanged: ((Int) -> Void)? = nil) {
		self.type = type
		super.init(frame: .zero)
		setupUI()
		counter.valueChanged = valueChanged
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }
}

// MARK: - Private Methods

private extension CounterWithTitleView {

	func setupUI() {
		addSubviews(stackView)
		stackView.pinToSuperviewEdges()

		NSLayoutConstraint.activate([
			counter.heightAnchor.constraint(
				equalToConstant: Constants.counterHeight
			)
		])
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI
@available(iOS 17.0, *)
#Preview {
	let height: CGFloat = 75

	VStack {
		UIViewPreview {
			CounterWithTitleView(type: .players)
		}
		.frame(height: height)

		UIViewPreview {
			CounterWithTitleView(type: .teams)
		}
		.frame(height: height)
	}
	.padding()
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
