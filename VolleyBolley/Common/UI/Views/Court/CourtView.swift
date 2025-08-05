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
		courtButtonsViewType: CourtButtonsViewType = .oneButton,
		detailsButtonData: CourtButtonData? = nil
	) {
		descriptionView.addArrangedSubview(courtDescriptionView)
		courtImageView.configure(with: court)
		courtDescriptionView.configure(with: court)

		courtButtonsView.configure(
				type: courtButtonsViewType,
				doneButtonData: doneButtonData,
				detailsButtonData: detailsButtonData
			)
		setupButtonsUI(courtButtonsViewType: courtButtonsViewType)
	}

	func configure(
		with court: CourtModel,
		for game: GameModel,
		hostType: HostType,
		doneButtonData: CourtButtonData,
		courtButtonsViewType: CourtButtonsViewType = .oneButton,
		detailsButtonData: CourtButtonData? = nil
	) {
		descriptionView.addArrangedSubview(gameDescriptionView)
		courtImageView.configure(with: court)
		gameDescriptionView.configure(with: game, hostType: hostType)

		courtButtonsView.configure(
				type: courtButtonsViewType,
				doneButtonData: doneButtonData,
				detailsButtonData: detailsButtonData
			)
		setupButtonsUI(courtButtonsViewType: courtButtonsViewType)
	}
}

// MARK: - Private Methods

private extension CourtView {

	func setupButtonsUI(courtButtonsViewType: CourtButtonsViewType) {
		switch courtButtonsViewType {
		case .oneButton:
			courtButtonsView.widthAnchor.constraint(equalToConstant: 215).isActive = false
			courtButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		case .twoButtons:
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
				courtButtonsViewType: .oneButton,
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
