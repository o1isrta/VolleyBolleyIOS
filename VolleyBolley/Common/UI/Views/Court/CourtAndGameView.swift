//
//  CourtAndGameView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

// MARK: - CourtAndGameViewModel

struct CourtViewModel {
	let court: CourtModel
	let doneButtonData: CourtButtonData
	let detailsButtonData: CourtButtonData?

	init(
		court: CourtModel,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		self.court = court
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

// MARK: - GameViewModel

struct GameViewModel {
	let court: CourtModel
	let game: GameModel
	let hostType: HostType
	let doneButtonData: CourtButtonData
	let detailsButtonData: CourtButtonData?

	init(
		court: CourtModel,
		game: GameModel,
		hostType: HostType,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		self.court = court
		self.game = game
		self.hostType = hostType
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

// MARK: - CourtAndGameView

/// Custom View to show information for two variants
/// - with court details
/// - with game details (host, game details)
final class CourtAndGameView: UIView {

	// MARK: - Private Properties

	private lazy var courtImageView = CourtImageView()
	private lazy var courtDescriptionView = CourtDescriptionView()
	private lazy var gameDescriptionView = GameDescriptionView()
	private lazy var courtButtonsView = CourtButtonsView()

	private lazy var descriptionView: UIStackView = {
		let stackView = UIStackView()
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

	func configure(with model: CourtViewModel) {
		descriptionView.addArrangedSubview(courtDescriptionView)

		let courtImageViewModel = CourtImageViewModel(
			imageURL: model.court.imageUrl,
			tags: model.court.tagList
		)
		courtImageView.configure(with: courtImageViewModel)

		let courtDescriptionModel = CourtDescriptionViewModel(
			price: model.court.price,
			description: model.court.description,
			contact: model.court.contacts?[0].value
		)
		courtDescriptionView.configure(with: courtDescriptionModel)

		let courtButtonsViewModel = CourtButtonsViewModel(
			doneButtonData: model.doneButtonData,
			detailsButtonData: model.detailsButtonData
		)
		courtButtonsView.configure(with: courtButtonsViewModel)
		setupButtonsUI(isExistDetailsButton: model.detailsButtonData != nil)
	}

	func configure(with model: GameViewModel) {
		descriptionView.addArrangedSubview(gameDescriptionView)

		let courtImageViewModel = CourtImageViewModel(
			imageURL: model.court.imageUrl,
			tags: model.court.tagList
		)
		courtImageView.configure(with: courtImageViewModel)

		let gameDescriptionViewModel = GameDescriptionViewModel(
			hostType: model.hostType,
			hostFirstName: model.game.host.firstName,
			hostLastName: model.game.host.lastName,
			hostLevel: model.game.host.levelType,
			hostAvatarURL: model.game.host.avatarURL,
			startTime: model.game.startTime,
			endTime: model.game.endTime,
			gameLevels: model.game.levels,
			gameGender: model.game.gender
		)
		gameDescriptionView.configure(with: gameDescriptionViewModel)

		let courtButtonsViewModel = CourtButtonsViewModel(
			doneButtonData: model.doneButtonData,
			detailsButtonData: model.detailsButtonData
		)
		courtButtonsView.configure(with: courtButtonsViewModel)
		setupButtonsUI(isExistDetailsButton: model.detailsButtonData != nil)
	}
}

// MARK: - Private Methods

private extension CourtAndGameView {

	func setupButtonsUI(isExistDetailsButton: Bool) {
		if isExistDetailsButton {
			courtButtonsView.widthAnchor.constraint(equalToConstant: 215).isActive = false
			courtButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		} else {
			courtButtonsView.widthAnchor.constraint(equalToConstant: 205).isActive = true
			courtButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		}
	}

	func setupUI() {
		addSubviews(
			courtImageView,
			descriptionView,
			courtButtonsView
		)

		NSLayoutConstraint.activate([
			courtImageView.topAnchor.constraint(equalTo: topAnchor),
			courtImageView.heightAnchor.constraint(equalToConstant: 193),
			courtImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			courtImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

			descriptionView.topAnchor.constraint(equalTo: courtImageView.bottomAnchor, constant: 16),
			descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor),

			courtButtonsView.heightAnchor.constraint(equalToConstant: 44),

			courtButtonsView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
			courtButtonsView.leadingAnchor.constraint(equalTo: leadingAnchor),
			courtButtonsView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)

#Preview("Game") {
	UIViewPreview {
		let view = CourtAndGameView()
		let model = GameViewModel(
			court: CourtModel.mockData,
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
	.padding()
	.frame(width: .infinity, height: 473)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}

#Preview("Court") {
	UIViewPreview {
		let view = CourtAndGameView()
		let model = CourtViewModel(
			court: CourtModel.mockData,
			doneButtonData: CourtButtonData(
				title: "Choose this court",
				action: { print("aaaaaaa")}
			)
		)
		view.configure(with: model)
		return view
	}
	.padding()
	.frame(width: .infinity, height: 416)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
