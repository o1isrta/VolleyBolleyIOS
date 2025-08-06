//
//  CourtBottomView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

/// Custom bottom view to display information with location name and custom number of buttons
final class CourtBottomView: UIView {

	// MARK: - Private Properties

	private lazy var courtTitleView: CourtTitleView = CourtTitleView(type: .icon)
	private lazy var courtButtonsView = CourtButtonsView()

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

	func configure(
		with court: CourtModel,
		distance: String,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		let courtTitleViewModel = CourtTitleViewModel(
			title: court.location.courtName,
			location: court.location.locationName,
			distance: distance
		)
		courtTitleView.configure(with: courtTitleViewModel)

		let courtButtonsViewModel = CourtButtonsViewModel(
			doneButtonData: doneButtonData,
			detailsButtonData: detailsButtonData
		)
		courtButtonsView.configure(with: courtButtonsViewModel)
		setupButtonsUI(isExistDetailsButton: detailsButtonData != nil)
	}
}

// MARK: - Private Methods

private extension CourtBottomView {

	func setupButtonsUI(isExistDetailsButton: Bool) {
		if isExistDetailsButton {
			courtButtonsView.widthAnchor.constraint(equalToConstant: 205).isActive = true
			courtButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
		} else {
			courtButtonsView.widthAnchor.constraint(equalToConstant: 215).isActive = false
			courtButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
		}
	}

	func setupUI() {
		backgroundColor = AppColor.Background.screen// TODO: need replace to glass effect
		layer.cornerRadius = 32
		layer.masksToBounds = true

		addSubviews(
			courtTitleView,
			courtButtonsView
		)

		NSLayoutConstraint.activate([
			courtTitleView.heightAnchor.constraint(equalToConstant: 36),
			courtTitleView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			courtTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			courtTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

			courtButtonsView.topAnchor.constraint(equalTo: courtTitleView.bottomAnchor, constant: 16),
			courtButtonsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			courtButtonsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
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
			view.configure(
					with: court,
					distance: "Nearest",
					doneButtonData: CourtButtonData(
						title: "CHOOSE THIS GAME",
						action: { print("aaaaaaa")}
						),
					detailsButtonData: CourtButtonData(
						title: "Details",
						action: { print("bbbbbbb")}
					)
				)
			return view
		}
		.frame(width: .infinity, height: 136)
		.background(Color(cgColor: AppColor.Background.screen.cgColor))
		.padding()

		UIViewPreview {
			let view = CourtBottomView()
			let court = CourtModel.mockData
			view.configure(
					with: court,
					distance: "",
					doneButtonData: CourtButtonData(
						title: "CHOOSE THIS GAME",
						action: { print("aaaaaaa")}
						),
					detailsButtonData: CourtButtonData(
						title: "Details",
						action: { print("bbbbbbb")}
					)
				)
			return view
		}
		.frame(width: .infinity, height: 136)
		.background(Color(cgColor: AppColor.Background.screen.cgColor))
		.padding()

		UIViewPreview {
			let view = CourtBottomView()
			let court = CourtModel.mockData
			view.configure(
					with: court,
					distance: "",
					doneButtonData: CourtButtonData(
						title: "CHOOSE THIS GAME",
						action: { print("aaaaaaa")}
						)
				)
			return view
		}
		.frame(width: .infinity, height: 136)
		.background(Color(cgColor: AppColor.Background.screen.cgColor))
		.padding()
	}
}
#endif
