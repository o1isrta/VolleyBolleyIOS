//
//  CourtView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

/// Custom View to show information for two variants
/// - with court details
/// - with game details (host, game details)
final class CourtView: UIView {

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

	func configure(
		with court: CourtModel,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		descriptionView.addArrangedSubview(courtDescriptionView)

		let courtImageViewModel = CourtImageViewModel(
			imageURL: court.imageUrl,
			tags: court.tagList
		)
		courtImageView.configure(with: courtImageViewModel)

		let courtDescriptionModel = CourtDescriptionViewModel(
			price: court.price,
			description: court.description,
			contact: court.contacts?[0].value
		)
		courtDescriptionView.configure(with: courtDescriptionModel)

		let courtButtonsViewModel = CourtButtonsViewModel(
			doneButtonData: doneButtonData,
			detailsButtonData: detailsButtonData
		)
		courtButtonsView.configure(with: courtButtonsViewModel)
		setupButtonsUI(isExistDetailsButton: detailsButtonData != nil)
	}

	func configure(
		with court: CourtModel,
		for game: GameModel,
		hostType: HostType,
		doneButtonData: CourtButtonData,
		detailsButtonData: CourtButtonData? = nil
	) {
		descriptionView.addArrangedSubview(gameDescriptionView)

		let courtImageViewModel = CourtImageViewModel(
			imageURL: court.imageUrl,
			tags: court.tagList
		)
		courtImageView.configure(with: courtImageViewModel)

		let gameDescriptionViewModel = GameDescriptionViewModel(
			hostType: hostType,
			hostFirstName: game.host.firstName,
			hostLastName: game.host.lastName,
			hostLevel: game.host.levelType,
			hostAvatarURL: game.host.avatarURL,
			startTime: game.startTime,
			endTime: game.endTime,
			gameLevels: game.levels,
			gameGender: game.gender
		)
		gameDescriptionView.configure(with: gameDescriptionViewModel)

		let courtButtonsViewModel = CourtButtonsViewModel(
			doneButtonData: doneButtonData,
			detailsButtonData: detailsButtonData
		)
		courtButtonsView.configure(with: courtButtonsViewModel)
		setupButtonsUI(isExistDetailsButton: detailsButtonData != nil)
	}
}

// MARK: - Private Methods

private extension CourtView {

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
		let view = CourtView()
		let court = CourtModel.mockData
		let game = GameModel.mockData
		view.configure(
				with: court,
				for: game,
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
		return view
	}
	.padding()
	.frame(width: .infinity, height: 473)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}

#Preview("Court") {
	UIViewPreview {
		let view = CourtView()
		let court = CourtModel.mockData
		view.configure(
				with: court,
				doneButtonData: CourtButtonData(
					title: "Choose this court",
					action: { print("aaaaaaa")}
				)
			)
		return view
	}
	.padding()
	.frame(width: .infinity, height: 416)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
