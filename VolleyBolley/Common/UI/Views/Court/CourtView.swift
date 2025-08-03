//
//  CourtView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

enum CourtViewType: CaseIterable {
	case oneSmallButton
	case oneBigButton
	case twoButton
}

final class CourtView: UIView {

	// MARK: - Private Properties

	private lazy var courtImageView = CourtImageView()
	private lazy var courtDescriptionView = CourtDescriptionView()
	private lazy var gameDescriptionView = GameDescriptionView()

	private lazy var chooseButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Choose this court", for: .normal)
		button.backgroundColor = .systemBlue// TODO
		button.setTitleColor(.white, for: .normal)// TODO
		button.layer.cornerRadius = 12// TODO
		return button
	}()

	private lazy var detailsButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Details", for: .normal)
		button.backgroundColor = .gray// TODO
		button.setTitleColor(.white, for: .normal)// TODO
		button.layer.cornerRadius = 12// TODO
		button.isHidden = true
		return button
	}()

	private lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.alignment = .leading
		stackView.distribution = .fill
		stackView.addArrangedSubview(chooseButton)
		stackView.addArrangedSubview(detailsButton)
		return stackView
	}()

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

	func configure(with court: CourtModel, courtViewType: CourtViewType = .oneBigButton) {
		descriptionView.addArrangedSubview(courtDescriptionView)
		setupCourtView(type: courtViewType)
		courtImageView.configure(with: court)
		courtDescriptionView.configure(with: court)
	}

	func configure(
		with court: CourtModel,
		for game: GameModel,
		hostType: HostType,
		courtViewType: CourtViewType = .oneBigButton
	) {
		descriptionView.addArrangedSubview(gameDescriptionView)
		setupCourtView(type: courtViewType)
		courtImageView.configure(with: court)
		gameDescriptionView.configure(with: game, hostType: hostType)
	}
}

// MARK: - Private Methods

private extension CourtView {

	func setupCourtView(type courtViewType: CourtViewType) {
		switch courtViewType {
		case .oneBigButton:
			buttonStackView.widthAnchor.constraint(equalToConstant: 215).isActive = false
			buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
			detailsButton.isHidden = true
		case .oneSmallButton:
			buttonStackView.widthAnchor.constraint(equalToConstant: 215).isActive = true
			buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = false
			detailsButton.isHidden = true
		case .twoButton:
			chooseButton.widthAnchor.constraint(equalToConstant: 205).isActive = true
			detailsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
			detailsButton.isHidden = false
		}
	}

	func setupUI() {
		addSubviews(
			courtImageView,
			descriptionView,
			buttonStackView
		)

		NSLayoutConstraint.activate([
			courtImageView.topAnchor.constraint(equalTo: topAnchor),
			courtImageView.heightAnchor.constraint(equalToConstant: 193),
			courtImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			courtImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

			descriptionView.topAnchor.constraint(equalTo: courtImageView.bottomAnchor, constant: 16),
			descriptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor),

			chooseButton.heightAnchor.constraint(equalToConstant: 44),
			detailsButton.heightAnchor.constraint(equalToConstant: 44),

			buttonStackView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
			buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
		view
			.configure(
				with: court,
				for: game,
				hostType: .game,
				courtViewType: .oneBigButton
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
		view.configure(with: court)
		return view
	}
	.padding()
	.frame(width: .infinity, height: 416)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
