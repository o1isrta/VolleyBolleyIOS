//
//  CourtButtonsView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import UIKit

// MARK: - CourtButtonsViewModel

struct CourtButtonsViewModel {
	let doneButtonData: ButtonDataModel
	let detailsButtonData: ButtonDataModel?

	init(
		doneButtonData: ButtonDataModel,
		detailsButtonData: ButtonDataModel? = nil
	) {
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

final class CourtButtonsView: UIView {

	// MARK: - Private Properties

	private var doneButtonCallback: (() -> Void)?
	private var detailsButtonCallback: (() -> Void)?

	// TODO: refactoding
	private lazy var doneButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .systemBlue
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 16
		button.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
		return button
	}()

	// TODO: refactoding
	private lazy var detailsButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .systemGray5
		button.setTitleColor(.systemBlue, for: .normal)
		button.layer.cornerRadius = 16
		button.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
		return button
	}()

	private lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [doneButton, detailsButton])
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.alignment = .leading
		stackView.distribution = .fill
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

			doneButton.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 3/5).isActive = true
			detailsButton.isHidden = false
		} else {
			doneButton.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 3/5).isActive = false
			detailsButton.isHidden = true
		}
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

	func setupUI() {
		backgroundColor = .clear

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
