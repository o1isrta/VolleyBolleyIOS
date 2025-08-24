//
//  CourtButtonsView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import UIKit

typealias CourtButtonData = (title: String, action: () -> Void)

// MARK: - CourtButtonsViewModel

struct CourtButtonsViewModel {
	let doneButtonData: CourtButtonData
	let detailsButtonData: CourtButtonData?

	init(
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

final class CourtButtonsView: UIView {

	// MARK: - Private Properties

	private var doneButtonCallback: (() -> Void)?
	private var detailsButtonCallback: (() -> Void)?

	private lazy var doneButton: YellowButton = {
		let button = YellowButton()
		button.isSelected = true
		button.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
		return button
	}()
	private lazy var detailsButton: YellowButton = {
		let button = YellowButton()
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

			doneButton.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 4/6).isActive = true
			detailsButton.isHidden = false
		} else {
			doneButton.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 4/6).isActive = false
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

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	VStack {
		UIViewPreview {
			let view = CourtBottomView()
			let court = CourtModel.mockData
			let model = CourtBottomViewModel(
				courtName: court.location.courtName,
				locationName: court.location.locationName,
				distance: String(localized: "Nearest"),
				doneButtonData: CourtButtonData(
					title: String(localized: "CHOOSE THIS GAME"),
					action: { print("aaaaaaa") }
				),
				detailsButtonData: CourtButtonData(
					title: String(localized: "DETAILS"),
					action: { print("bbbbbbb") }
				)
			)
			view.configure(with: model)
			return view
		}
		.frame(width: .infinity, height: 136)
		.padding()

		UIViewPreview {
			let view = CourtBottomView()
			let court = CourtModel.mockData
			let model = CourtBottomViewModel(
				courtName: court.location.courtName,
				locationName: court.location.locationName,
				distance: "",
				doneButtonData: CourtButtonData(
					title: String(localized: "CHOOSE THIS GAME"),
					action: { print("aaaaaaa") }
				)
			)
			view.configure(with: model)
			return view
		}
		.frame(width: .infinity, height: 136)
		.padding()
	}
}
#endif
