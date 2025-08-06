//
//  CourtButtonsView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import UIKit

typealias CourtButtonData = (title: String, action: () -> Void)

enum CourtButtonsViewType: CaseIterable {
	case oneButton
	case twoButtons
}

// MARK: - CourtButtonsViewModel

struct CourtButtonsViewModel {
	let type: CourtButtonsViewType
	let doneButtonData: CourtButtonData
	let detailsButtonData: CourtButtonData?

	init(
		type: CourtButtonsViewType,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		self.type = type
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

final class CourtButtonsView: UIView {

	// MARK: - Public Properties

	private var doneButtonCallback: (() -> Void)?
	private var detailsButtonCallback: (() -> Void)?

	private lazy var doneButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .systemBlue
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 16
		button.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
		return button
	}()

	private lazy var detailsButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .systemGray5
		button.setTitleColor(.systemBlue, for: .normal)
		button.layer.cornerRadius = 16
		button.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
		return button
	}()

	private lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.alignment = .leading
		stackView.distribution = .fill
		stackView.addArrangedSubview(doneButton)
		stackView.addArrangedSubview(detailsButton)
		return stackView
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

	func configure(with model: CourtButtonsViewModel) {
		doneButton.setTitle(model.doneButtonData.title, for: .normal)
		doneButtonCallback = model.doneButtonData.action

		if let detailsButtonData = model.detailsButtonData {
			detailsButton.setTitle(detailsButtonData.title, for: .normal)
			detailsButtonCallback = detailsButtonData.action
		}

		setupButtonsUI(courtButtonsViewType: model.type)
	}
}

// MARK: - Private Methods

private extension CourtButtonsView {

	@objc func didTapChooseButton() {
		doneButtonCallback?()
	}

	@objc func didTapDetailsButton() {
		detailsButtonCallback?()
	}

	func setupButtonsUI(courtButtonsViewType: CourtButtonsViewType) {
		switch courtButtonsViewType {
		case .oneButton:
			buttonStackView.widthAnchor.constraint(equalToConstant: 215).isActive = false
			buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
			detailsButton.isHidden = true
		case .twoButtons:
			doneButton.widthAnchor.constraint(equalToConstant: 205).isActive = true
			detailsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
			detailsButton.isHidden = false
		}
	}

	func setupUI() {
		backgroundColor = .clear
		// button stack
		[
			doneButton,
			detailsButton
		].forEach {
			buttonStackView.addArrangedSubview($0)
		}

		addSubviews(buttonStackView)

		NSLayoutConstraint.activate([
			doneButton.heightAnchor.constraint(equalToConstant: 44),
			detailsButton.heightAnchor.constraint(equalToConstant: 44),

			buttonStackView.topAnchor.constraint(equalTo: topAnchor),
			buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
