//
//  CourtTitleView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.08.2025.
//

import UIKit

// MARK: - CourtTitleViewModel

struct CourtTitleViewModel {
	let title: String
	let location: String
	let distance: String
}

enum CourtTitleViewType: CaseIterable {
	case icon
	case none

	var isIconHidden: Bool {
		switch self {
		case .icon: return false
		case .none: return true
		}
	}
}

final class CourtTitleView: UIView {

	// MARK: - Private Properties

	private var locationTitleView: LocationTitleView
	private lazy var distanceView = DistanceView()

	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [locationTitleView, distanceView])
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = 10
		return stackView
	}()

	// MARK: - Initializers

	init(type: CourtTitleViewType) {
		self.locationTitleView = LocationTitleView(type: type)
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(with model: CourtTitleViewModel) {
		locationTitleView.configure(
			with: LocationTitleViewModel(
				title: model.title,
				location: model.location
			)
		)
		distanceView.configure(distance: model.distance)
		distanceView.isHidden = model.distance.isEmpty
	}
}

// MARK: - Private Methods

private extension CourtTitleView {

	func setupUI() {
		backgroundColor = .clear
		addSubviews(mainStackView)
		NSLayoutConstraint.activate([
			locationTitleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),

			mainStackView.topAnchor.constraint(equalTo: topAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

// TODO: - refactor Preview

// #if DEBUG
// import SwiftUI
// @available(iOS 17.0, *)
// #Preview {
//	ZStack {
//		Color(cgColor: AppColor.Background.screen.cgColor)
//
//		VStack {
//			UIViewPreview {
//				let view = CourtTitleView(type: .icon)
//				let court = Court.mockData
//				let model = CourtTitleViewModel(
//					title: court.location.courtName,
//					location: court.location.locationName,
//					distance: "Nearest"
//				)
//				view.configure(with: model)
//				return view
//			}
//			.frame(width: .infinity, height: 36)
//			.padding()
//
//			Divider()
//				.background(Color(.systemGray5))
//
//			UIViewPreview {
//				let view = CourtTitleView(type: .icon)
//				let court = Court.mockData
//				let model = CourtTitleViewModel(
//					title: court.location.courtName,
//					location: court.location.locationName,
//					distance: "2 km"
//				)
//				view.configure(with: model)
//				return view
//			}
//			.frame(width: .infinity, height: 36)
//			.padding()
//
//			Divider()
//				.background(Color(.systemGray5))
//
//			UIViewPreview {
//				let view = CourtTitleView(type: .none)
//				let court = Court.mockData
//				let model = CourtTitleViewModel(
//					title: court.location.courtName,
//					location: court.location.locationName,
//					distance: ""
//				)
//				view.configure(with: model)
//				return view
//			}
//			.frame(width: .infinity, height: 36)
//			.padding()
//
//			Divider()
//				.background(Color(.systemGray5))
//
//			UIViewPreview {
//				let view = CourtTitleView(type: .none)
//				let court = Court.mockData
//				let model = CourtTitleViewModel(
//					title: court.location.courtName,
//					location: court.location.locationName,
//					distance: "Nearest"
//				)
//				view.configure(with: model)
//				return view
//			}
//			.frame(width: .infinity, height: 36)
//			.padding()
//		}
//	}
//	.ignoresSafeArea()
// }
// #endif
