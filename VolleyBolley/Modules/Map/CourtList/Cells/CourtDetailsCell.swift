//
//  CourtDetailsCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.07.2025.
//

import UIKit

class CourtDetailsCell: UITableViewCell {

	// MARK: - Private Properties

	private let courtAndGameView = CourtAndGameView()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(with court: CourtModel) {
		let model = CourtViewModel(
			court: court,
			doneButtonData: CourtButtonData(
				title: "CHOOSE THIS COURT",
				action: { print("CHOOSE THIS COURT: click clack") }
			)
		)
		courtAndGameView.configure(with: model)
	}
}

// MARK: - Private Methods

private extension CourtDetailsCell {

	func setupUI() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubviews(courtAndGameView)
		NSLayoutConstraint.activate([
			courtAndGameView.topAnchor.constraint(equalTo: contentView.topAnchor),
			courtAndGameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			courtAndGameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			courtAndGameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
