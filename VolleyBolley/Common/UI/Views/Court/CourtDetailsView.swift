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
	let doneButtonData: ButtonDataModel
	let detailsButtonData: ButtonDataModel?

	init(
		court: CourtModel,
		distance: String,
		doneButtonData: ButtonDataModel,
		detailsButtonData: ButtonDataModel? = nil
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
	let doneButtonData: ButtonDataModel
	let detailsButtonData: ButtonDataModel?

	init(
		court: CourtModel,
		distance: String,
		game: GameModel,
		hostType: HostType,
		doneButtonData: ButtonDataModel,
		detailsButtonData: ButtonDataModel? = nil
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

    private let glassView = GlassView(config: .court)

	private lazy var courtTitleView: CourtTitleView = CourtTitleView(type: .icon)

	private lazy var courtAndGameView: CourtAndGameView = CourtAndGameView()

	private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [courtTitleView, courtAndGameView])
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 16
		return stackView
	}()

	init() {
        super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(with model: CourtDetailsViewModel) {
		let courtTitleViewModel = CourtTitleViewModel(
			title: model.court.location.courtName,
			location: model.court.location.locationName,
			distance: model.distance
		)
		courtTitleView.configure(with: courtTitleViewModel)

		let courtViewModel = CourtViewModel(
			court: model.court,
			doneButtonData: model.doneButtonData,
			detailsButtonData: model.detailsButtonData
		)
		courtAndGameView.configure(with: courtViewModel)
	}

	func configure(with model: GameDetailsViewModel) {
		let courtTitleViewModel = CourtTitleViewModel(
			title: model.court.location.courtName,
			location: model.court.location.locationName,
			distance: model.distance
		)
		courtTitleView.configure(with: courtTitleViewModel)

		let courtViewModel = GameViewModel(
			court: model.court,
			game: model.game,
			hostType: model.hostType,
			doneButtonData: model.doneButtonData,
			detailsButtonData: model.detailsButtonData
		)
		courtAndGameView.configure(with: courtViewModel)
	}
}

private extension CourtDetailsView {

	private func setupUI() {
        addSubviews(glassView, mainStack)

        glassView.pinToSuperviewEdges()

		NSLayoutConstraint.activate([
			mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

			courtTitleView.heightAnchor.constraint(equalToConstant: 36),
			courtAndGameView.heightAnchor.constraint(equalToConstant: 380)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview("Game") {
	UIViewPreview {
		let view = CourtDetailsView()

		let model = GameDetailsViewModel(
			court: CourtModel.mockData,
			distance: String(localized: "Nearest"),
			game: GameModel.mockData,
			hostType: .game,
			doneButtonData: ButtonDataModel(
				title: String(localized: "CHOOSE THIS GAME"),
				action: { print("aaaaaaa") }
				),
			detailsButtonData: ButtonDataModel(
				title: String(localized: "DETAILS"),
				action: { print("bbbbbbb") }
			)
		)
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 509)
	.padding()
}

#Preview("Court") {
	UIViewPreview {
		let view = CourtDetailsView()
		let model = CourtDetailsViewModel(
			court: CourtModel.mockData,
			distance: String(localized: "Nearest"),
			doneButtonData: ButtonDataModel(
				title: String(localized: "CHOOSE THIS GAME"),
				action: { print("aaaaaaa") }
				),
			detailsButtonData: ButtonDataModel(
				title: String(localized: "DETAILS"),
				action: { print("bbbbbbb") }
			)
		)
		view.configure(with: model)
		return view
	}
	.frame(width: .infinity, height: 472)
	.padding()
}
#endif
