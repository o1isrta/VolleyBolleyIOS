//
//  CourtBottomView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

final class CourtBottomView: UIView {

	// MARK: - Public Properties

	var chooseButtonCallback: (() -> Void)?
	var detailsButtonCallback: (() -> Void)?

	// MARK: - Private Properties

	private lazy var courtTitleView: CourtTitleView = CourtTitleView()

	private lazy var buttonStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 8
		stack.distribution = .fillEqually
		return stack
	}()

	private lazy var chooseButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle(
			String(localized: "Choose this court"),
			for: .normal
		)
		button.backgroundColor = .systemBlue
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 16
		button.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
		return button
	}()

	private lazy var detailsButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle(
			String(localized: "Details"),
			for: .normal
		)
		button.backgroundColor = .systemGray5
		button.setTitleColor(.systemBlue, for: .normal)
		button.layer.cornerRadius = 16
		button.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
		return button
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(with court: CourtModel, isNearest: Bool) {
		courtTitleView.configure(with: court, isNearest: isNearest)
	}
}

// MARK: - Private Methods

private extension CourtBottomView {

	@objc func didTapChooseButton() {
		chooseButtonCallback?()
	}

	@objc func didTapDetailsButton() {
		detailsButtonCallback?()
	}

	func setupUI() {
		backgroundColor = AppColor.Background.screen// TODO: need replace to glass effect
		layer.cornerRadius = 32
		layer.masksToBounds = true
		// button stack
		[
			chooseButton,
			detailsButton
		].forEach {
			buttonStackView.addArrangedSubview($0)
		}

		addSubviews(
			courtTitleView,
			buttonStackView
		)

		NSLayoutConstraint.activate([
			courtTitleView.heightAnchor.constraint(equalToConstant: 36),
			courtTitleView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			courtTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			courtTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

			courtTitleView.heightAnchor.constraint(equalToConstant: 44),
			buttonStackView.topAnchor.constraint(equalTo: courtTitleView.bottomAnchor, constant: 16),
			buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
		])
	}
}
