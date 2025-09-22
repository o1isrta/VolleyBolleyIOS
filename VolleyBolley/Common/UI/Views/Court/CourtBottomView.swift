//
//  CourtBottomView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

// MARK: - CourtBottomViewModel

struct CourtBottomViewModel {
	let courtName: String
	let locationName: String
	let distance: String
	let doneButtonData: ButtonDataModel
	let detailsButtonData: ButtonDataModel?

	init(
		courtName: String,
		locationName: String,
		distance: String,
		doneButtonData: ButtonDataModel,
		detailsButtonData: ButtonDataModel? = nil
	) {
		self.courtName = courtName
		self.locationName = locationName
		self.distance = distance
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

// MARK: - CourtBottomView

/// Custom bottom view to display information with location name and custom number of buttons
final class CourtBottomView: GlassmorphismView {

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

	func configure(with model: CourtBottomViewModel) {
		let courtTitleViewModel = CourtTitleViewModel(
			title: model.courtName,
			location: model.locationName,
			distance: model.distance
		)
		courtTitleView.configure(with: courtTitleViewModel)

		let courtButtonsViewModel = CourtButtonsViewModel(
			doneButtonData: model.doneButtonData,
			detailsButtonData: model.detailsButtonData
		)
		courtButtonsView.configure(with: courtButtonsViewModel)
	}
}

// MARK: - Private Methods

private extension CourtBottomView {

	func setupUI() {
		backgroundColor = AppColor.Background.screen
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
			courtButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			courtButtonsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
		])
	}
}

//#if DEBUG
//import SwiftUI
//@available(iOS 17.0, *)
//#Preview {
//	VStack {
//		UIViewPreview {
//			let view = CourtBottomView()
//			let court = Court.mockData
//			let model = CourtBottomViewModel(
//				courtName: court.location.courtName,
//				locationName: court.location.locationName,
//				distance: String(localized: "Nearest"),
//				doneButtonData: ButtonDataModel(
//					title: String(localized: "CHOOSE THIS GAME"),
//					action: { print("aaaaaaa") }
//				),
//				detailsButtonData: ButtonDataModel(
//					title: String(localized: "DETAILS"),
//					action: { print("bbbbbbb") }
//				)
//			)
//			view.configure(with: model)
//			return view
//		}
//		.frame(width: .infinity, height: 136)
//		.padding()
//
//		UIViewPreview {
//			let view = CourtBottomView()
//			let court = Court.mockData
//			let model = CourtBottomViewModel(
//				courtName: court.location.courtName,
//				locationName: court.location.locationName,
//				distance: "",
//				doneButtonData: ButtonDataModel(
//					title: String(localized: "CHOOSE THIS GAME"),
//					action: { print("aaaaaaa") }
//				),
//				detailsButtonData: ButtonDataModel(
//					title: String(localized: "DETAILS"),
//					action: { print("bbbbbbb") }
//				)
//			)
//			view.configure(with: model)
//			return view
//		}
//		.frame(width: .infinity, height: 136)
//		.padding()
//
//		UIViewPreview {
//			let view = CourtBottomView()
//			let court = Court.mockData
//			let model = CourtBottomViewModel(
//				courtName: court.location.courtName,
//				locationName: court.location.locationName,
//				distance: "",
//				doneButtonData: ButtonDataModel(
//					title: String(localized: "CHOOSE THIS GAME"),
//					action: { print("aaaaaaa") }
//				)
//			)
//			view.configure(with: model)
//			return view
//		}
//		.frame(width: .infinity, height: 136)
//		.padding()
//	}
//}
//#endif
