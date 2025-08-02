//
//  CourtDetailsView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

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

	func configure(with court: CourtModel, distance: String) {
		courtTitleView.configure(with: court, distance: distance)
		courtView.configure(with: court)
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
