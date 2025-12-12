//
//  CourtButtonsView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import UIKit

// MARK: - CourtButtonsViewModel

struct CourtButtonsViewModel {
	let doneButtonData: ButtonDataModel
	let detailsButtonData: ButtonDataModel?

	init(
		doneButtonData: ButtonDataModel,
		detailsButtonData: ButtonDataModel? = nil
	) {
		self.doneButtonData = doneButtonData
		self.detailsButtonData = detailsButtonData
	}
}

final class CourtButtonsView: UIView {

	// MARK: - Private Properties

	private enum LayoutConstants {
		static let spacing: CGFloat = 8
		static let buttonHeight: CGFloat = 44
	}

	private var doneButtonCallback: (() -> Void)?
	private var detailsButtonCallback: (() -> Void)?

	private lazy var doneButton: YellowButton = {
		let button = YellowButton()
		button.isSelected = true
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.doneButtonCallback?()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var detailsButton: YellowButton = {
		let button = YellowButton()
		button.addAction(UIAction { [weak self] _ in
			guard let self else { return }
			self.detailsButtonCallback?()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [doneButton, detailsButton])
		stackView.axis = .horizontal
		stackView.spacing = LayoutConstants.spacing
		stackView.alignment = .leading
		stackView.distribution = .fillProportionally
		return stackView
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(with model: CourtButtonsViewModel) {
		doneButton.setTitle(model.doneButtonData.title, for: .normal)
		doneButtonCallback = model.doneButtonData.action
		detailsButton.isHidden = true

		if let detailsButtonData = model.detailsButtonData {
			detailsButton.isHidden = false
			detailsButton.setTitle(detailsButtonData.title, for: .normal)
			detailsButtonCallback = detailsButtonData.action
		}
	}
}

// MARK: - Private Methods

private extension CourtButtonsView {

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		addSubviews(buttonStackView)

		buttonStackView.pinToSuperviewEdges()
		NSLayoutConstraint.activate([
			doneButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
			detailsButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight)
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
		.frame(width: .infinity, height: 136)
		.padding()

		UIViewPreview {
			let view = CourtBottomView()
			let court = CourtModel.mockData
			let model = CourtBottomViewModel(
				courtName: court.location.courtName,
				locationName: court.location.locationName,
				distance: "",
				doneButtonData: ButtonDataModel(
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
