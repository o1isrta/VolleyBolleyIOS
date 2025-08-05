//
//  CourtDetailsView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

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

	func configure(
		with court: CourtModel,
		distance: String,
		doneButtonData: CourtButtonData,
		courtButtonsViewType: CourtButtonsViewType = .oneButton,
		detailsButtonData: CourtButtonData? = nil
	) {
		courtTitleView.configure(with: court, distance: distance)
		courtView.configure(
				with: court,
				doneButtonData: doneButtonData,
				courtButtonsViewType: courtButtonsViewType,
				detailsButtonData: detailsButtonData
			)
	}

	func configure(
		with court: CourtModel,
		distance: String,
		game: GameModel,
		hostType: HostType,
		doneButtonData: CourtButtonData,
		courtButtonsViewType: CourtButtonsViewType = .oneButton,
		detailsButtonData: CourtButtonData? = nil
	) {
		courtTitleView.configure(with: court, distance: distance)
		courtView.configure(
				with: court,
				for: game,
				hostType: hostType,
				doneButtonData: doneButtonData,
				courtButtonsViewType: courtButtonsViewType,
				detailsButtonData: detailsButtonData
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
		view.configure(
			with: court,
			distance: "",
			game: game,
			hostType: .game,
			doneButtonData: CourtButtonData(
				title: "CHOOSE THIS GAME",
				action: { print("aaaaaaa")}
				),
			courtButtonsViewType: .twoButtons,
			detailsButtonData: CourtButtonData(
				title: "Details",
				action: { print("bbbbbbb")}
			)
		)
		return view
	}
	.frame(width: .infinity, height: 509)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}

#Preview("Court") {
	UIViewPreview {
		let view = CourtDetailsView()
		let court = CourtModel.mockData
		view.configure(
			with: court,
			distance: "Nearest",
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
	.frame(width: .infinity, height: 472)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
