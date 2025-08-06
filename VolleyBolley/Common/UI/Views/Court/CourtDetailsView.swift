//
//  CourtDetailsView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

// MARK: - CourtDetailsViewModel

struct CourtDetailsViewModel {
	let court: CourtModel
	let distance: String
	let doneButtonData: CourtButtonData
	let detailsButtonData: CourtButtonData?

	init(
		court: CourtModel,
		distance: String,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		self.court = court
		self.distance = distance
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

// MARK: - GameDetailsViewModel

struct GameDetailsViewModel {
	let court: CourtModel
	let distance: String
	let game: GameModel
	let hostType: HostType
	let doneButtonData: CourtButtonData
	let detailsButtonData: CourtButtonData?

	init(
		court: CourtModel,
		distance: String,
		game: GameModel,
		hostType: HostType,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		self.court = court
		self.distance = distance
		self.game = game
		self.hostType = hostType
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

// MARK: - CourtDetailsView

/// Custom View to show information with location title for two variants
/// - with court details
/// - with game details (host, game details)
class CourtDetailsView: UIView {

	// MARK: - Private Properties

	private lazy var courtTitleView: CourtTitleView = CourtTitleView(type: .icon)

	private lazy var courtView: CourtView = CourtView()

	private lazy var mainStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 16
		return stackView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	// MARK: - Public Methods

	func configure(with model: CourtDetailsViewModel) {
		let courtTitleViewModel = CourtTitleViewModel(
			title: model.court.location.courtName,
			location: model.court.location.locationName,
			distance: model.distance
		)
		courtTitleView.configure(with: courtTitleViewModel)

		courtView.configure(
			with: model.court,
			doneButtonData: model.doneButtonData,
			detailsButtonData: model.detailsButtonData
		)
	}

	func configure(with model: GameDetailsViewModel) {
		let courtTitleViewModel = CourtTitleViewModel(
			title: model.court.location.courtName,
			location: model.court.location.locationName,
			distance: model.distance
		)
		courtTitleView.configure(with: courtTitleViewModel)

		courtView.configure(
			with: model.court,
			for: model.game,
			hostType: model.hostType,
			doneButtonData: model.doneButtonData,
			detailsButtonData: model.detailsButtonData
			)
	}
}

private extension CourtDetailsView {

	private func setupUI() {
		backgroundColor = AppColor.Background.screen// TODO: need replace to glass effect
		layer.cornerRadius = 32
		layer.masksToBounds = true
		// main stack
		[
			courtTitleView,
			courtView
		].forEach {
			mainStack.addArrangedSubview($0)
		}

		addSubviews(mainStack)
		NSLayoutConstraint.activate([
			mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

			courtTitleView.heightAnchor.constraint(equalToConstant: 36),
			courtView.heightAnchor.constraint(equalToConstant: 380)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview("Game") {
	UIViewPreview {
		let view = CourtDetailsView()
		let court = CourtModel.mockData
		let game = GameModel.mockData

		let model = GameDetailsViewModel(
			court: CourtModel.mockData,
			distance: "Nearest",
			game: GameModel.mockData,
			hostType: .game,
			doneButtonData: CourtButtonData(
				title: "CHOOSE THIS GAME",
				action: { print("aaaaaaa")}
				),
			detailsButtonData: CourtButtonData(
				title: "Details",
				action: { print("bbbbbbb")}
			)
		)
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 509)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}

#Preview("Court") {
	UIViewPreview {
		let view = CourtDetailsView()
		let model = CourtDetailsViewModel(
			court: CourtModel.mockData,
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
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 472)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
